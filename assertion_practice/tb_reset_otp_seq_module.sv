// Top-level testbench for reset_otp_seq_module + assertion_interface

`timescale 1ns/1ps
`include "reset_otp_seq_module.sv"
`include "assertion_interface.sv"

module tb_reset_otp_seq_module;

  // Clock signal
  bit clk_osc_100k = 0;

  // PORZ control (driven manually for stimulus)
  reg porz_val;

  // Clock generation: 100kHz (10us period → 5ns half-cycle in sim)
  always #5 clk_osc_100k = ~clk_osc_100k;

  // Instantiate interface
  assertion_interface intf(clk_osc_100k);

  // Drive PORZ from local reg to interface wire
  assign intf.porz = porz_val;

  // Instantiate DUT
  reset_otp_seq_module DUT (
    .clk_osc_100k(intf.clk_osc_100k),
    .porz(intf.porz),
    .rst_otp(intf.rst_otp),
    .rstz_i2c_reg(intf.rstz_i2c_reg),
    .rstz_otp_100k(intf.rstz_otp_100k),
    .otp_rdy(intf.otp_rdy),
    .reset_timer_done(intf.reset_timer_done)
  );

  // Stimulus
  initial begin
    // Initial reset state
    porz_val = 0;
    @(negedge clk_osc_100k);

    // Release PORZ to start OTP sequence
    porz_val = 1;
    @(negedge clk_osc_100k);

    // Wait long enough for the entire sequence to complete
    repeat (30) @(negedge clk_osc_100k);

    // Optional PORZ toggle for additional testing
    // porz_val = 0; #200;
    // porz_val = 1; #500;

    $finish;
  end

  // Enable waveform dump
  initial begin
    $dumpfile("reset_otp_seq.vcd");
    $dumpvars(0, tb_reset_otp_seq_module);
  end

endmodule



