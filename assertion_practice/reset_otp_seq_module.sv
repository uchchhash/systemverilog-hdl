// -----------------------------------------------------------------------------
// Simulation-only behavioral model for OTP Reset Sequence Logic
// -----------------------------------------------------------------------------

module reset_otp_seq_module(
    input  wire clk_osc_100k,
    input  wire porz,                // Active-high power-on reset release
    output reg  rst_otp,
    output reg  rstz_i2c_reg,
    output reg  rstz_otp_100k,
    output reg  otp_rdy,
    output reg  reset_timer_done
);

  // ---------------------------------------------------------------------------
  // Initialize all outputs to zero
  // ---------------------------------------------------------------------------
  initial begin
    rst_otp          = 0;
    rstz_i2c_reg     = 0;
    rstz_otp_100k    = 0;
    otp_rdy          = 0;
    reset_timer_done = 0;
  end

  // ---------------------------------------------------------------------------
  // OTP Reset Sequence Generator — Simulation only
  // Models sequential enablement of reset lines after PORZ becomes high
  // ---------------------------------------------------------------------------
  always @(posedge clk_osc_100k) begin
    $display("[%0t] Porz = %0b", $time, porz);

    if (porz) begin
      // Step 1: Wait 4 clocks, assert rst_otp
      repeat (4) @(posedge clk_osc_100k);
      rst_otp <= 1;

      // Step 2: Wait 3 clocks, assert rstz_i2c_reg and rstz_otp_100k
      repeat (3) @(posedge clk_osc_100k);
      rstz_i2c_reg  <= 1;
      rstz_otp_100k <= 1;

      // Step 3: Wait 4 clocks, assert otp_rdy
      repeat (4) @(posedge clk_osc_100k);
      otp_rdy <= 1;

      // Step 4: Wait 4 clocks, assert reset_timer_done
      repeat (4) @(posedge clk_osc_100k);
      reset_timer_done <= 1;
    end
    else begin
      // Asynchronous reset fallback
      rst_otp          <= 0;
      rstz_i2c_reg     <= 0;
      rstz_otp_100k    <= 0;
      otp_rdy          <= 0;
      reset_timer_done <= 0;
    end
  end

endmodule
