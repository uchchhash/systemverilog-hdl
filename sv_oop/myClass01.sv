// =====================================================
// 📘 SystemVerilog Class and Module in One File
// Includes: Class Definition + Constructor Usage + Test
// =====================================================

`timescale 1ns/1ps

// --------------------------------------------
// ✅ Class Definition: myClass01
// --------------------------------------------

class myClass01;

  // 🔸 Data Members (class variables)
  int    a1 = 10;   // Initialized to 10
  bit    b1;        // 1-bit variable (binary only)
  logic  c1;        // 4-state variable (0, 1, X, Z)

  // 🔸 Constructor: executes when object is created
  function new(int a);
    $display("=====>> Class 01 constructed");
    a1 = a;  // Overrides default a1 value
    $display("=====>> a1 = %0d", a1);
  endfunction

  // 🔸 Method to display current values
  task display_vals();
    $display("=====>> [Class-1] a1 = %0d || b1 = %0d || c1 = %0d", a1, b1, c1);
  endtask

endclass

// --------------------------------------------
// ✅ Module to Use the Class
// --------------------------------------------

module myModule;

  // Declare object handle
  myClass01 obj;

  initial begin
    $display("\n=====>> Simulation Started <<=====\n");

    // 🔹 Create object with constructor argument 42
    obj = new(42); // Calls 'new' constructor of myClass01

    // 🔹 Assign additional member values
    obj.b1 = 1;
    obj.c1 = 0;

    // 🔹 Call method to display values
    obj.display_vals();

    $display("\n=====>> Simulation Completed <<=====\n");
    $finish;
  end

endmodule
