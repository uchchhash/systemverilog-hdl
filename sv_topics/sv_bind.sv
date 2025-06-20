`timescale 1ns/1ps

// -----------------------------------------------------------------------------
// DUT (Design Under Test): A simple module with handshake logic
// -----------------------------------------------------------------------------
module dut (
    input  logic clk,
    input  logic rst_n,
    input  logic valid,
    input  logic ready,
    input  logic [7:0] data
);

    // Handshake signal generation
    logic handshake;
    assign handshake = valid & ready;

endmodule


// -----------------------------------------------------------------------------
// Assertion Module: Contains handshake protocol assertions
// -----------------------------------------------------------------------------
module handshake_assertions (
    input logic clk,
    input logic rst_n,
    input logic valid,
    input logic ready
);

    // Property: Once valid is asserted, it must be held until ready is high
    property valid_stable_until_ready;
        @(posedge clk) disable iff (!rst_n)
        valid |-> ##[0:$] ready;
    endproperty

    // Assertion instance for the above property
    assert property (valid_stable_until_ready)
        else $error(" VALID was deasserted before READY became high!");

endmodule


// -----------------------------------------------------------------------------
// Bind Statement: Binds assertions to all instances of the DUT module
// -----------------------------------------------------------------------------
bind dut handshake_assertions u_handshake_assertions (
    .clk   (clk),
    .rst_n (rst_n),
    .valid (valid),
    .ready (ready)
);


// -----------------------------------------------------------------------------
// Testbench Module: Drives stimulus to verify the DUT + assertions
// -----------------------------------------------------------------------------
module tb;

    logic clk, rst_n;
    logic valid, ready;
    logic [7:0] data;

    // Instantiate the DUT
    dut u_dut (
        .clk   (clk),
        .rst_n (rst_n),
        .valid (valid),
        .ready (ready),
        .data  (data)
    );

    // Clock Generation: 10ns period
    always #5 clk = ~clk;

    // Test Stimulus
    initial begin
        // Initial state
        clk = 0;
        rst_n = 0;
        valid = 0;
        ready = 0;
        data  = 8'h00;

        // Apply reset
        #12 rst_n = 1;

        // Case 1: Valid asserted, ready not yet
        #10 valid = 1;
        #10 valid = 0;  //  Error expected here if ready is still 0

        // Ready becomes high after valid dropped (should've stayed high longer)
        #10 ready = 1;

        // Case 2: Valid held until ready becomes high ( Good case)
        #10 valid = 1; ready = 0;
        #10 ready = 1; valid = 0;

        // Wrap-up simulation
        #20 $finish;
    end

endmodule
