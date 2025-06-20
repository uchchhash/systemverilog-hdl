interface assert_intf(input logic clock);

  // --------------------------------------------------------------------------
  // Signal Declarations
  // These can be driven or monitored from the testbench or DUT
  // --------------------------------------------------------------------------
  logic a, b, c, d, e;

  // --------------------------------------------------------------------------
  // Assertion Sequences (Commented Out for Now)
  // Define temporal patterns that can be reused in properties
  // --------------------------------------------------------------------------
  /*
  // Sequence 1: (Placeholder – Not defined yet)
  sequence seq1;
    // TODO: Define the sequence pattern
  endsequence;

  // Sequence 2: a -> b -> c -> d on consecutive clock cycles
  sequence seq2;
    @(posedge clock) a ##1 b ##1 c ##1 d;
  endsequence;
  */

  // --------------------------------------------------------------------------
  // Assertion Properties
  // --------------------------------------------------------------------------

  // Property p1:
  // If 'b' is high, then two clock cycles *before* that, 'a' must have been high.
  // Then, on the next cycles, 'c' and then 'd' must also be high.
  /*
  property p1;
    @(posedge clock)
      b |-> ($past(a, 2) == 1) |=> c |=> d;
  endproperty
  */

  // Property p2:
  // A chain reaction: a -> b -> c -> d, each on the next clock
  /*
  property p2;
    @(posedge clock)
      a |=> b |=> c |=> d;
  endproperty
  */

  // --------------------------------------------------------------------------
  // Assertions
  // Use these to check if the properties hold during simulation
  // --------------------------------------------------------------------------

  // Assert p1 (temporal dependency with $past)
  /*
  assertion_1 : assert property (p1)
                 else $error("Assertion p1 FAILED: 'a' was not high 2 cycles before 'b'.");
  */

  // Assert p2 (chained implication)
  /*
  assertion_2 : assert property (p2)
                 else $error("Assertion p2 FAILED: a -> b -> c -> d sequence violated.");
  */

endinterface
