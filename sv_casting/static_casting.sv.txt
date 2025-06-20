// ==============================================
// 📘 SystemVerilog Static Casting Demo
// ==============================================
// This example shows how to use static casting to convert:
//   - string → int (ASCII)
//   - real → int (truncates decimal)
//   - int → real
//   - expression → int (with ternary conditional)
// ==============================================

module casting_example;

  string name;       // Used to demonstrate string-to-int casting
  int num[3];        // Integer array to store cast results
  real r_num;        // Real value for float-to-int and int-to-float

  initial begin
    // ------------------------------------------
    // Example 1: Cast string to int
    // ------------------------------------------
    name = "A";                 // ASCII code of "A" = 65
    num[0] = int'(name);        // Cast string to int → will take ASCII of first char

    // ------------------------------------------
    // Example 2: Cast real to int
    // ------------------------------------------
    r_num = 2.8;                // Floating-point value
    num[1] = int'(r_num);       // Cast real to int → truncates to 2

    // ------------------------------------------
    // Example 3: Cast int to real
    // ------------------------------------------
    // Create a real value using int literal (concatenation: {4'h1, 4'hA} = 8'h1A = 26)
    r_num = 2.125 + real'({4'h1, 4'hA});  // 2.125 + 26 = 28.125

    // ------------------------------------------
    // Example 4: Cast conditional real result to int
    // ------------------------------------------
    // If num[0] == 65 (true), cast r_num (28.125) to int → num[2] = 28
    // Else cast 4.7 to int → would be 4
    num[2] = int'((num[0] == 65) ? r_num : 4.7);

    // ------------------------------------------
    // Print results
    // ------------------------------------------
    $display("casting from string to int: num[0] = %0d", num[0]); // Expected: 65
    $display("casting from real to int:   num[1] = %0d", num[1]); // Expected: 2
    $display("casting from int to real:   r_num   = %0f", r_num);  // Expected: 28.125
    $display("casting expression to int:  num[2] = %0d", num[2]); // Expected: 28
  end

endmodule
