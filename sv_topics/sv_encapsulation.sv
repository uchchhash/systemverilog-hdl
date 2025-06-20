//======================================================================//
//================= Data Hiding and Encapsulation Demo ================//
//======================================================================//

// Encapsulation is a core object-oriented concept that ensures data hiding
// and abstraction by controlling access to internal class members.

// SystemVerilog provides the following access qualifiers:
// - `local`     : Accessible only within the class itself. Not inherited.
// - `protected` : Accessible within the class and by derived classes.
// - default     : Public access (no keyword) — accessible from outside via instance.


//==================== Parent Class Definition ========================//
class parent_class;

  // 'local' variable: Completely hidden from outside and even subclasses.
  local int a = 10;

  // 'protected' variable: Hidden from outside, but accessible in subclasses.
  protected int b = 20;

  // 'protected' method: Visible only inside this class and derived classes.
  protected function void dispValue();
    $display("[Disp1] A = %0d || B = %0d", a, b);

    // Call local method from within the class — valid.
    dispValue2();
  endfunction

  // 'local' method: Not accessible even from child classes.
  local function void dispValue2();
    $display("[Disp2] A = %0d || B = %0d", a, b);
  endfunction

endclass


//==================== Child Class Definition =========================//
class child_class extends parent_class;

  // Instantiating parent class is not necessary here but included for demo
  parent_class pc1;

  // Constructor
  function new();
    // Accessing a protected function of the parent — valid.
    super.dispValue();  

    // Attempting to access local variable or method from parent will fail.
    // super.dispValue2();  // This would cause a compilation error.
  endfunction

endclass


//======================= Testbench Module ============================//
module sv_encapsulation;

  parent_class pc1;
  child_class cc1;

  initial begin
    // Create object of child class
    cc1 = new();

    // The following will cause a compilation error because
    // dispValue() is a protected method and cannot be accessed directly from outside.
    // pc1.dispValue();  // Illegal access

    // However, the protected method was successfully called within the constructor of `child_class`.
  end

endmodule
