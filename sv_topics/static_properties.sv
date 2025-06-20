//============================================================
// Demonstration of Static Properties in SystemVerilog
//============================================================

// -----------------------------
// Class: parentClass
// -----------------------------
class parentClass;

    // Non-static (instance) variable
    // Each object will have its own copy
    int counter;

    // Static variable
    // Shared by all instances of this class and subclasses
    static int static_counter;

    // Constructor: increments both counters when a new object is created
    function new();
        counter++;              // Affects only this instance
        static_counter++;       // Affects global class-level counter
        $display("parent-class-created [counter = %0d][static_counter = %0d]", counter, static_counter);
    endfunction

    // Static task
    // Can access only static members (not `counter`)
    static task sTask();
        // counter++; // ❌ Illegal: static methods cannot access non-static members
        static_counter++; // ✅ OK: static accessing static
        $display("static-task-called . . . . . [counter = %0d] [static_counter = %0d]", 0, static_counter);
    endtask

endclass


// -----------------------------
// Class: childClass (extends parentClass)
// -----------------------------
class childClass extends parentClass;

    // Constructor: Calls parent constructor and prints message
    function new();
        super.new(); // Call to parent constructor
        $display("child-class-created");
    endfunction

endclass


// -----------------------------
// Top Module to Simulate
// -----------------------------
module tb;

    // Declare three objects of childClass
    childClass cc1, cc2, cc3;

    initial begin
        // Create three instances of childClass
        cc1 = new(); // Increments both counter and static_counter
        cc2 = new(); // Same
        cc3 = new(); // Same

        // Call static task using class name
        // No object required to call this static method
        childClass::sTask(); // Increments static_counter only
    end

endmodule
