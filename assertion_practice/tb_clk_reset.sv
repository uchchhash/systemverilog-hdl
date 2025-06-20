`include "dut_clk_reset.sv"
`timescale 1ns/1ps

module tb_clk_otp_100k();

  // DUT Ports
  wire out;
  reg clk_osc_100k;
  reg [1:0] mode;
  reg soft_reset;
  reg porz;

  // Instantiate DUT
  clk_otp_100k_module DUT (
    .out(out),
    .clk_osc_100k(clk_osc_100k),
    .mode(mode),
    .soft_reset(soft_reset),
    .porz(porz)
  );

  // Local parameter for clock period
  parameter real CLK_100K_PERIOD_NS = 1_000_000.0 / 100_000.0;  // 10,000ns (100kHz)

  // Clock Generator: 100kHz clock
  initial begin
    clk_osc_100k = 0;
    forever #(CLK_100K_PERIOD_NS/2) clk_osc_100k = ~clk_osc_100k;
  end

  // Stimulus
  initial begin
    // Default values
    mode = 2'b00;
    porz = 0;
    soft_reset = 0;

    #100;

    // Change mode and observe behavior
    mode = 2'b00;  #100;
    mode = 2'b01;  #100;
    mode = 2'b10;  #100;
    mode = 2'b11;  #100;

    // Pulse PORZ (simulate power-on release)
    porz = 0; #100;
    porz = 1; #100;

    // Toggle soft reset
    soft_reset = 0; #100;
    soft_reset = 1; #100;

    // Wait to observe waveform
    #1000;

    $finish();
  end

  // Dump waveform
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_clk_otp_100k);
  end

endmodule
