//==============================================================
// Concept: Typed Constructor in SystemVerilog
//==============================================================
// - Demonstrates how to call a derived class (child class) constructor
//   and assign it to a handle of the base (parent) class type.
//
// - This is a core concept in **polymorphism** where a base-class handle
//   can point to a derived-class object.
//
// - Even though the handle is of base class type, it will call the
//   derived class constructor, and the derived class instance will be created.
//
// - Useful when working with polymorphic code where the type is resolved
//   at runtime.
//==============================================================


// --------------------- Parent Class -------------------------
class parentClass;

    // Constructor of parent class
    function new();
        $display("Parent Class Created");
    endfunction

endclass


// --------------------- Child Class --------------------------
class childClass extends parentClass;

    // Constructor of child class
    function new();
        super.new(); // Call the base class constructor
        $display("Child Class Created");
    endfunction

endclass


// ------------------------ Testbench --------------------------
module tb;

    initial begin
        // Create a handle of the base class type
        // Instantiate an object of the derived class using ::new()
        parentClass pc = childClass::new();

        // Output:
        // Parent Class Created
        // Child Class Created
    end

endmodule
