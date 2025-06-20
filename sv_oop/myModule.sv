// ===============================================
// 📘 SystemVerilog Example: Class Inheritance Demo
// myClass02 extends myClass01
// ===============================================

// Include external class files
`include "myClass01.sv"  // Base class definition
`include "myClass02.sv"  // Derived class definition

module myModule;

  // Local module-level variables
  int aa;
  bit bb;
  logic cc;

  // Initial block for basic setup/logging
  initial begin
    aa = 20;
    $display("=====>> Inside - My - Module | aa = %0d", aa);
  end

  /*
  --------------------------------------------------------
  🔸 Optional Block to Test myClass01 Standalone
  --------------------------------------------------------
  Uncomment this section to test only the base class.
  initial begin
    myClass01 mc1;             // Declare handle
    mc1 = new(aa);             // Create instance with constructor argument
    mc1.display_vals();        // Display values in base class
  end
  */

  //--------------------------------------------------------
  // 🔹 Main Block to Test myClass02 (Derived Class)
  //--------------------------------------------------------
  initial begin
    myClass02 mc2;              // Declare handle for derived class
    mc2 = new();                // Calls derived constructor → calls base constructor
    mc2.display_vals2();        // Displays values from both base and derived classes
  end

endmodule
