// -----------------------------------------------------------------------------
// Example: Using $assertcontrol system task in SystemVerilog (VCS-specific)
// Author: Uchchhash Sarkar
// Purpose: Demonstrate dynamic enabling, disabling, freezing, and thawing 
//          of assertions in simulation
// -----------------------------------------------------------------------------

module assert_control_example;

  // ---------------------------------------------------------------------------
  // Signal Declarations
  // ---------------------------------------------------------------------------

  logic clk = 0;        // Clock signal
  logic rst_n = 0;      // Active-low reset
  logic a = 0;          // Test signal for assertion checking

  // ---------------------------------------------------------------------------
  // Clock Generator: Generates a clock with 10 time unit period
  // ---------------------------------------------------------------------------
  always #5 clk = ~clk;

  // ---------------------------------------------------------------------------
  // Assertion Property: a must remain 0 after reset is deasserted
  //
  // This assertion checks that the signal 'a' stays low (== 0)
  // when reset is high (== 1). If 'a' goes high, the assertion fails.
  // ---------------------------------------------------------------------------
  property p_never_a_is_one;
    @(posedge clk) disable iff (!rst_n) a == 0;
  endproperty

  // Bind the property to an assert statement
  // If assertion fails, an error message will be printed
  assert property (p_never_a_is_one)
    else $error("ASSERTION FAILED: Signal 'a' went high when it should be low!");

  // ---------------------------------------------------------------------------
  // Initial Block: Drives stimulus and demonstrates $assertcontrol usage
  // ---------------------------------------------------------------------------
  initial begin

    // Step 1: Apply Reset
    rst_n = 0;  // Assert reset
    a = 0;      // Make sure 'a' is initially 0
    #10;
    rst_n = 1;  // Deassert reset, system becomes active

    // -------------------------------------------------------------------------
    // Step 2: Disable All Assertions
    // -------------------------------------------------------------------------
    $display("\n--- Disabling all assertions ---");
    $assertcontrol("off");  // This disables ALL types of assertions

    // Violate the assertion condition: set 'a' to 1
    // Since assertions are turned off, this violation is not reported
    a = 1;
    #10;

    // -------------------------------------------------------------------------
    // Step 3: Re-enable All Assertions
    // -------------------------------------------------------------------------
    $display("\n--- Enabling all assertions ---");
    $assertcontrol("on");   // Reactivates all assertions

    // Set 'a' to 0 before the next test
    a = 0;
    #10;

    // Again violate the assertion: this time it will be caught and reported
    a = 1;
    #10;

    // -------------------------------------------------------------------------
    // Step 4: Freeze Assertions
    // -------------------------------------------------------------------------
    $display("\n--- Freezing assertions ---");
    $assertcontrol("freeze");  // Temporarily pauses all assertion checking

    // Even though we are violating the assertion again, it won’t fire
    a = 0;
    #10;
    a = 1;
    #10;

    // -------------------------------------------------------------------------
    // Step 5: Thaw Assertions
    // -------------------------------------------------------------------------
    $display("\n--- Thawing assertions ---");
    $assertcontrol("thaw");  // Resumes assertion checking
    #10;

    // -------------------------------------------------------------------------
    // Step 6: Finish Simulation
    // -------------------------------------------------------------------------
    $display("\n--- Ending simulation ---");
    $finish;
  end

endmodule
