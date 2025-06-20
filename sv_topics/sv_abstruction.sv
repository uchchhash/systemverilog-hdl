//======================================================//
//============== SystemVerilog Abstraction =============//
//======================================================//

// Abstraction is one of the key pillars of OOP. It hides implementation details 
// and shows only essential features to the user. SystemVerilog supports abstraction
// through `virtual classes`, `virtual methods`, and access specifiers like `protected` and `local`.


// -------------------------------
// Virtual Class: parent_class
// -------------------------------
virtual class parent_class;

    // Local variable: completely hidden from child classes and external access
    // Used to enforce data hiding (encapsulation)
    local int a = 2;

    // Protected variable: accessible within the class and any subclass
    // Helps in creating controlled abstraction
    protected int b = 3;

    // Virtual function: to be overridden in derived classes
    // Demonstrates polymorphism and abstraction
    virtual function void dispValue();
        $display("[Disp1] A = %0d || B = %0d", a, b);
    endfunction

endclass


// -------------------------------
// Class: child_class
// -------------------------------
class child_class extends parent_class;

    // Handle of type parent_class
    // Demonstrates polymorphism: can point to objects of derived classes
    parent_class pc1;

    // Override the virtual function to customize behavior
    virtual function void dispValue();
        super.dispValue(); // Call the parent class version of the function
        $display("Display from Child Class . . . .");
    endfunction

    // Constructor: calls the overridden function
    function new();
        dispValue();  // Executes child version of dispValue()
    endfunction

endclass


// -------------------------------
// Module: sv_encapsulation
// -------------------------------
module sv_encapsulation;

    // Handles of parent and child classes
    parent_class pc1;
    child_class cc1;

    initial begin
        // Create an object of child class
        cc1 = new();

        // Accessing parent handle is optional here
        // pc1.dispValue(); // Uncomment if needed
    end

endmodule
