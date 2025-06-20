module tb_clk_adc_sch_12m();

  // Clock and control signals
  bit clk_osc_100k = 0;
  bit clk_adc_sch_12m = 0;

  // Inputs to logic
  bit [1:0] adc_clock_select = 0;
  bit reset_timer_done = 0;
  bit en_sleepmode = 0;
  bit adc_reset_n = 0;
  bit dis_hfclock_gating = 0;

  // Functional enable signals
  bit adc_monx_cfg = 0;
  bit clear_px_average = 0;
  bit vbus_discharge_en = 0;

  // Internal derived enables
  bit ungate_en;
  bit sleepmode_en;
  bit clk_adc_sch_en;

  // Frequency tracker
  real frequency;

  // Clock generation
  always #5000 clk_osc_100k = ~clk_osc_100k;           // 100kHz
  always #40   if (clk_adc_sch_en) clk_adc_sch_12m = ~clk_adc_sch_12m;  // 12.5MHz when enabled

  // Derived control logic, updated on slow clock
  always @(posedge clk_osc_100k) begin
    ungate_en     = (adc_monx_cfg || clear_px_average || vbus_discharge_en);
    sleepmode_en  = (!en_sleepmode && adc_clock_select != 2'b01);
    clk_adc_sch_en = (reset_timer_done || ungate_en || dis_hfclock_gating || sleepmode_en || adc_reset_n);
  end

  // Frequency measurement task (starts in parallel)
  initial fork
    measure_freq;
  join_none

  // Frequency measurement logic (based on timestamp)
  task measure_freq;
    real current_time;
    real previous_time;
    forever begin
      @(posedge clk_adc_sch_12m);
      if (previous_time != $realtime) begin        
        current_time = $realtime / 1s; // Convert from ns to seconds
        frequency = 1.0 / (current_time - previous_time);        
      end else begin
        frequency = 0;
      end
      previous_time = $realtime / 1s;
    end
  endtask

  // Stimulus block
  initial begin
    // Default state
    adc_reset_n = 0;
    adc_clock_select = 2'b00;
    en_sleepmode = 0;
    dis_hfclock_gating = 0;
    reset_timer_done = 0;

    #10000;
    adc_reset_n = 1;
    reset_timer_done = 1;

    repeat_display("Valid range with adc_reset_n = 1");

    adc_clock_select = 2'b01;
    en_sleepmode = 1;
    #10000;
    repeat_display("Valid range if adc_clock_select = 01");

    adc_clock_select = 2'b00;
    en_sleepmode = 1;
    #10000;
    repeat_display("Valid range because en_sleepmode = 1");

    adc_clock_select = 2'b01;
    en_sleepmode = 0;
    #10000;
    repeat_display("Valid range because adc_clock_select = 01");

    adc_clock_select = 2'b00;
    en_sleepmode = 0;
    #10000;
    repeat_display("Should be 0, clk disabled");

    adc_reset_n = 0;
    #10000;
    repeat_display("Should be 0, adc_reset_n = 0");

    dis_hfclock_gating = 1;
    #10000;
    repeat_display("Valid range with dis_hfclock_gating = 1");

    en_sleepmode = 1;
    #10000;
    repeat_display("Valid range, en_sleepmode = 1");

    en_sleepmode = 0;
    #10000;
    repeat_display("Valid range, en_sleepmode = 0");

    dis_hfclock_gating = 0;
    #10000;
    repeat_display("Should be 0 again");

    $finish;
  end

  // Reusable display block
  task repeat_display(input string label);
    $display("[%0t] %s\n  ungate_en = %0d, sleepmode_en = %0d, clk_adc_sch_en = %0d, Frequency = %0e Hz",
             $time, label, ungate_en, sleepmode_en, clk_adc_sch_en, frequency);
  endtask

endmodule
