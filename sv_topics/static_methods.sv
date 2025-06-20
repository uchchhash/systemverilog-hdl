//============================================================
// Demonstration of Static Methods and Variables in SystemVerilog
//============================================================

// Define a class
class ExampleClass;

    // ----------- Static Variable -----------
    // Shared by all instances of this class.
    // Only one copy exists regardless of how many objects are created.
    static int shared_counter = 0;

    // ----------- Instance Variable -----------
    // Each object of the class has its own copy of this variable.
    int instance_var;

    // ----------- Static Method -----------
    // Can be called using the class name directly.
    // Cannot access non-static (instance) variables or methods.
    static function void increment_shared_counter();
        shared_counter++; // Increment shared static counter
        $display("Shared Counter: %0d", shared_counter);
    endfunction

    // ----------- Instance Method 1 -----------
    // Can access and modify the instance-specific variable.
    function void set_instance_var(int value);
        instance_var = value;
    endfunction

    // ----------- Instance Method 2 -----------
    // Can access both instance and static members.
    function void display_vars();
        $display("Shared Counter: %0d, Instance Variable: %0d", shared_counter, instance_var);
    endfunction

endclass


//============================================================
// Module to Test Static Behavior
//============================================================
module top;

    initial begin
        // Create two instances (obj1 and obj2)
        ExampleClass obj1 = new();
        ExampleClass obj2 = new();

        // ---------- Static Method Call via Class Name ----------
        // Increments shared_counter for the entire class, not per object
        ExampleClass::increment_shared_counter(); // Output: Shared Counter: 1
        ExampleClass::increment_shared_counter(); // Output: Shared Counter: 2

        // ---------- Set Individual Instance Variables ----------
        obj1.set_instance_var(10);
        obj2.set_instance_var(20);

        // ---------- Display Variables ----------
        // Shows shared counter (static) and unique instance variables
        obj1.display_vars(); // Output: Shared Counter: 2, Instance Variable: 10
        obj2.display_vars(); // Output: Shared Counter: 2, Instance Variable: 20

        // ---------- Static Method via Object (allowed but NOT recommended) ----------
        obj1.increment_shared_counter(); // Output: Shared Counter: 3

        // ---------- Display Again After Static Change ----------
        obj1.display_vars(); // Output: Shared Counter: 3, Instance Variable: 10
        obj2.display_vars(); // Output: Shared Counter: 3, Instance Variable: 20
    end

endmodule
