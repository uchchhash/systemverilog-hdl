//==========================================================//
//         SystemVerilog Control Flow Constructs Demo        //
//==========================================================//

module control_flow_demo;

  // 2-bit selection input to simulate different control cases
  logic [1:0] sel;

  //==========================================================//
  //              Task: Demonstrate unique if                 //
  //==========================================================//
  // 'unique if' ensures that exactly one condition matches.
  // - If **none** of the conditions match: simulation warning or error
  // - If **more than one** condition matches (due to logic bug): simulation error
  // This helps catch unintended overlaps or gaps in condition coverage.
  task demo_unique_if();
    $display("\n---> Demonstrating 'unique if' with sel = %0b", sel);

    unique if (sel == 2'b00)
      $display("unique if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("unique if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("unique if: Matched sel == 10");
    // No 'else' clause used intentionally to show how unhandled values cause a violation
  endtask


  //==========================================================//
  //              Task: Demonstrate unique0 if                //
  //==========================================================//
  // 'unique0 if' is similar to 'unique if' but allows zero matches.
  // - If **zero or one** condition matches: valid
  // - If **more than one** matches: error
  // Used when it’s acceptable for none of the conditions to hold true
  task demo_unique0_if();
    $display("\n---> Demonstrating 'unique0 if' with sel = %0b", sel);

    unique0 if (sel == 2'b00)
      $display("unique0 if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("unique0 if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("unique0 if: Matched sel == 10");
    // No violation if no match occurs
  endtask


  //==========================================================//
  //              Task: Demonstrate priority if               //
  //==========================================================//
  // 'priority if' ensures that the first true condition is selected.
  // - Once a condition is true, later conditions are not evaluated.
  // - If no condition matches and no 'else' is provided, it's a warning.
  task demo_priority_if();
    $display("\n---> Demonstrating 'priority if' with sel = %0b", sel);

    priority if (sel == 2'b00)
      $display("priority if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("priority if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("priority if: Matched sel == 10");
    else
      $display("priority if: No match found, default else executed");
  endtask


  //==========================================================//
  //              Task: Demonstrate unique case               //
  //==========================================================//
  // 'unique case' ensures exactly one case item matches.
  // - If **no match** occurs: simulation warning or error
  // - If **more than one** matches: error (even though only first is executed)
  // Preferred for case-based decoders, FSMs, etc.
  task demo_unique_case();
    $display("\n---> Demonstrating 'unique case' with sel = %0b", sel);

    unique case (sel)
      2'b00: $display("unique case: Matched case 00");
      2'b01: $display("unique case: Matched case 01");
      2'b10: $display("unique case: Matched case 10");
      // No default added to test detection of uncovered value (e.g., sel = 2'b11)
    endcase
  endtask


  //==========================================================//
  //                     Initial Block                        //
  //==========================================================//
  initial begin
    //======================== TEST CASE 1 ========================//
    // sel = 2'b01 → All constructs should match one condition
    sel = 2'b01;
    $display("\n======== TEST CASE 1: sel = 01 ========");
    demo_unique_if();      // Valid: matches one
    demo_unique0_if();     // Valid: matches one
    demo_priority_if();    // Valid: matches one
    demo_unique_case();    // Valid: matches one

    //======================== TEST CASE 2 ========================//
    // sel = 2'b11 → No conditions match
    sel = 2'b11;
    $display("\n======== TEST CASE 2: sel = 11 ========");
    demo_unique_if();      // Violation: no match
    demo_unique0_if();     // Valid: no match allowed
    demo_priority_if();    // Valid: falls to else
    demo_unique_case();    // Violation: no case matches

    //======================== TEST CASE 3 ========================//
    // Manually introduce overlapping conditions for unique if
    // Hard to demo with literal values; handled during linting in real designs

    $display("\n======== END OF DEMO ========\n");
    #10 $finish;
  end

endmodule
//==========================================================//
//         SystemVerilog Control Flow Constructs Demo        //
//==========================================================//

module control_flow_demo;

  // 2-bit selection input to simulate different control cases
  logic [1:0] sel;

  //==========================================================//
  //              Task: Demonstrate unique if                 //
  //==========================================================//
  // 'unique if' ensures that exactly one condition matches.
  // - If **none** of the conditions match: simulation warning or error
  // - If **more than one** condition matches (due to logic bug): simulation error
  // This helps catch unintended overlaps or gaps in condition coverage.
  task demo_unique_if();
    $display("\n---> Demonstrating 'unique if' with sel = %0b", sel);

    unique if (sel == 2'b00)
      $display("unique if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("unique if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("unique if: Matched sel == 10");
    // No 'else' clause used intentionally to show how unhandled values cause a violation
  endtask


  //==========================================================//
  //              Task: Demonstrate unique0 if                //
  //==========================================================//
  // 'unique0 if' is similar to 'unique if' but allows zero matches.
  // - If **zero or one** condition matches: valid
  // - If **more than one** matches: error
  // Used when it’s acceptable for none of the conditions to hold true
  task demo_unique0_if();
    $display("\n---> Demonstrating 'unique0 if' with sel = %0b", sel);

    unique0 if (sel == 2'b00)
      $display("unique0 if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("unique0 if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("unique0 if: Matched sel == 10");
    // No violation if no match occurs
  endtask


  //==========================================================//
  //              Task: Demonstrate priority if               //
  //==========================================================//
  // 'priority if' ensures that the first true condition is selected.
  // - Once a condition is true, later conditions are not evaluated.
  // - If no condition matches and no 'else' is provided, it's a warning.
  task demo_priority_if();
    $display("\n---> Demonstrating 'priority if' with sel = %0b", sel);

    priority if (sel == 2'b00)
      $display("priority if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("priority if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("priority if: Matched sel == 10");
    else
      $display("priority if: No match found, default else executed");
  endtask


  //==========================================================//
  //              Task: Demonstrate unique case               //
  //==========================================================//
  // 'unique case' ensures exactly one case item matches.
  // - If **no match** occurs: simulation warning or error
  // - If **more than one** matches: error (even though only first is executed)
  // Preferred for case-based decoders, FSMs, etc.
  task demo_unique_case();
    $display("\n---> Demonstrating 'unique case' with sel = %0b", sel);

    unique case (sel)
      2'b00: $display("unique case: Matched case 00");
      2'b01: $display("unique case: Matched case 01");
      2'b10: $display("unique case: Matched case 10");
      // No default added to test detection of uncovered value (e.g., sel = 2'b11)
    endcase
  endtask


  //==========================================================//
  //                     Initial Block                        //
  //==========================================================//
  initial begin
    //======================== TEST CASE 1 ========================//
    // sel = 2'b01 → All constructs should match one condition
    sel = 2'b01;
    $display("\n======== TEST CASE 1: sel = 01 ========");
    demo_unique_if();      // Valid: matches one
    demo_unique0_if();     // Valid: matches one
    demo_priority_if();    // Valid: matches one
    demo_unique_case();    // Valid: matches one

    //======================== TEST CASE 2 ========================//
    // sel = 2'b11 → No conditions match
    sel = 2'b11;
    $display("\n======== TEST CASE 2: sel = 11 ========");
    demo_unique_if();      // Violation: no match
    demo_unique0_if();     // Valid: no match allowed
    demo_priority_if();    // Valid: falls to else
    demo_unique_case();    // Violation: no case matches

    //======================== TEST CASE 3 ========================//
    // Manually introduce overlapping conditions for unique if
    // Hard to demo with literal values; handled during linting in real designs

    $display("\n======== END OF DEMO ========\n");
    #10 $finish;
  end

endmodule
//==========================================================//
//         SystemVerilog Control Flow Constructs Demo        //
//==========================================================//

module control_flow_demo;

  // 2-bit selection input to simulate different control cases
  logic [1:0] sel;

  //==========================================================//
  //              Task: Demonstrate unique if                 //
  //==========================================================//
  // 'unique if' ensures that exactly one condition matches.
  // - If **none** of the conditions match: simulation warning or error
  // - If **more than one** condition matches (due to logic bug): simulation error
  // This helps catch unintended overlaps or gaps in condition coverage.
  task demo_unique_if();
    $display("\n---> Demonstrating 'unique if' with sel = %0b", sel);

    unique if (sel == 2'b00)
      $display("unique if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("unique if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("unique if: Matched sel == 10");
    // No 'else' clause used intentionally to show how unhandled values cause a violation
  endtask


  //==========================================================//
  //              Task: Demonstrate unique0 if                //
  //==========================================================//
  // 'unique0 if' is similar to 'unique if' but allows zero matches.
  // - If **zero or one** condition matches: valid
  // - If **more than one** matches: error
  // Used when it’s acceptable for none of the conditions to hold true
  task demo_unique0_if();
    $display("\n---> Demonstrating 'unique0 if' with sel = %0b", sel);

    unique0 if (sel == 2'b00)
      $display("unique0 if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("unique0 if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("unique0 if: Matched sel == 10");
    // No violation if no match occurs
  endtask


  //==========================================================//
  //              Task: Demonstrate priority if               //
  //==========================================================//
  // 'priority if' ensures that the first true condition is selected.
  // - Once a condition is true, later conditions are not evaluated.
  // - If no condition matches and no 'else' is provided, it's a warning.
  task demo_priority_if();
    $display("\n---> Demonstrating 'priority if' with sel = %0b", sel);

    priority if (sel == 2'b00)
      $display("priority if: Matched sel == 00");
    else if (sel == 2'b01)
      $display("priority if: Matched sel == 01");
    else if (sel == 2'b10)
      $display("priority if: Matched sel == 10");
    else
      $display("priority if: No match found, default else executed");
  endtask


  //==========================================================//
  //              Task: Demonstrate unique case               //
  //==========================================================//
  // 'unique case' ensures exactly one case item matches.
  // - If **no match** occurs: simulation warning or error
  // - If **more than one** matches: error (even though only first is executed)
  // Preferred for case-based decoders, FSMs, etc.
  task demo_unique_case();
    $display("\n---> Demonstrating 'unique case' with sel = %0b", sel);

    unique case (sel)
      2'b00: $display("unique case: Matched case 00");
      2'b01: $display("unique case: Matched case 01");
      2'b10: $display("unique case: Matched case 10");
      // No default added to test detection of uncovered value (e.g., sel = 2'b11)
    endcase
  endtask


  //==========================================================//
  //                     Initial Block                        //
  //==========================================================//
  initial begin
    //======================== TEST CASE 1 ========================//
    // sel = 2'b01 → All constructs should match one condition
    sel = 2'b01;
    $display("\n======== TEST CASE 1: sel = 01 ========");
    demo_unique_if();      // Valid: matches one
    demo_unique0_if();     // Valid: matches one
    demo_priority_if();    // Valid: matches one
    demo_unique_case();    // Valid: matches one

    //======================== TEST CASE 2 ========================//
    // sel = 2'b11 → No conditions match
    sel = 2'b11;
    $display("\n======== TEST CASE 2: sel = 11 ========");
    demo_unique_if();      // Violation: no match
    demo_unique0_if();     // Valid: no match allowed
    demo_priority_if();    // Valid: falls to else
    demo_unique_case();    // Violation: no case matches

    //======================== TEST CASE 3 ========================//
    // Manually introduce overlapping conditions for unique if
    // Hard to demo with literal values; handled during linting in real designs

    $display("\n======== END OF DEMO ========\n");
    #10 $finish;
  end

endmodule
