`include "assert_interface.sv"

module assertion_practice;

  // ---------------------------------------------------------------------------
  // Clock and Signal Declarations
  // ---------------------------------------------------------------------------
  bit clock = 0;            // Clock signal (starts from 0)
  logic x;                  // Unused signal placeholder

  // Instantiate the interface with the shared clock
  assert_intf intf(clock);

  // Optional pass/fail events (not used here but can be for coverage tracking)
  event pass, fail;

  // ---------------------------------------------------------------------------
  // Clock Generator (10 time unit period)
  // ---------------------------------------------------------------------------
  initial forever #5 clock = ~clock;

  // ---------------------------------------------------------------------------
  // Stimulus Generator: Drives test data into interface
  // ---------------------------------------------------------------------------
  initial begin
    // Initial reset phase: deassert all interface signals
    intf.a = 0;
    intf.b = 0;
    intf.c = 0;
    intf.d = 0;
    intf.e = 0;
    repeat (10) @(negedge clock);

    // Repeat a pattern to trigger assertions
    repeat(5) begin
      // Time step 1: only 'a' high
      intf.a = 1; intf.b = 0; intf.c = 0; intf.d = 0; intf.e = 0;
      @(negedge intf.clock);

      // Time step 2: 'a' and 'b' high
      intf.b = 1;
      @(negedge intf.clock);

      // Time step 3: 'a', 'b', 'c' high
      intf.c = 1;
      @(negedge intf.clock);

      // Time step 4: 'a', 'b', 'c', 'd' high
      intf.d = 1;
      @(negedge intf.clock);

      // Time step 5: everything high
      intf.e = 1;
      @(negedge intf.clock);
    end

    // Reset all signals after test
    intf.a = 0;
    intf.b = 0;
    intf.c = 0;
    intf.d = 0;
    intf.e = 0;
    repeat (10) @(negedge clock);
    
    $finish();
  end

  // ---------------------------------------------------------------------------
  // Sequence & Property Definitions
  // ---------------------------------------------------------------------------

  // Sequence: a -> b -> c -> d on consecutive cycles
  sequence seq2;
    intf.a ##1 intf.b ##1 intf.c ##1 intf.d;
  endsequence

  // Property: Apply sequence on posedge clock
  property p2;
    @(posedge clock) seq2;
  endproperty

  // Assertion: Check if sequence holds
  assertion_1: assert property (p2)
    else $error("Assertion Failed: a -> b -> c -> d sequence violation.");

  // ---------------------------------------------------------------------------
  // (Optional) Another property – commented out
  // Meaning: If b is high, then two cycles earlier a was high, then c, then d
  /*
  property p1;
    @(posedge clock) intf.b |-> ($past(intf.a,2) == 1) |=> intf.c |=> intf.d;
  endproperty

  assertion_2: assert property(p1)
    else $error("Assertion Failed: 'a' was not high 2 cycles before 'b'.");
  */

endmodule
