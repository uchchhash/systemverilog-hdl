// ===================================================
// 📘 SystemVerilog Dynamic Casting with $cast()
// ===================================================
// Used to safely cast a base class handle to a derived class
// at runtime, only if the object is assignment-compatible.
//
// Syntax:
//    if ($cast(derived_handle, base_handle)) begin
//      // success: base actually refers to a derived object
//    end else begin
//      // failure: base is not the right type
//    end
// ===================================================

class animal;
  string species;

  function void speak();
    $display("Animal: %s", species);
  endfunction
endclass


// ---------------------------------------------------
// Derived class: Dog (subclass of Animal)
// ---------------------------------------------------
class dog extends animal;
  function void bark();
    $display("🐶 Woof! I'm a dog.");
  endfunction
endclass


module dynamic_cast_example;

  // Declare base and derived class handles
  animal a;
  dog d;

  initial begin
    // --------------------------------------------
    // Step 1: Create a dog and assign to base class handle
    // --------------------------------------------
    d = new();
    d.species = "Dog";
    a = d;  // ✅ Legal: derived to base class assignment

    // --------------------------------------------
    // Step 2: Attempt to cast back to derived (base → derived)
    // --------------------------------------------
    dog d2;
    if ($cast(d2, a)) begin
      // ✅ Successful: a actually points to a 'dog'
      $display("✅ Cast successful: %s is a Dog", d2.species);
      d2.bark();
    end else begin
      // ❌ Should not occur in this case
      $display("❌ Cast failed: a is not a Dog");
    end

    // --------------------------------------------
    // Step 3: Try with a non-dog object
    // --------------------------------------------
    animal a2 = new();   // Plain Animal
    dog d3;
    if ($cast(d3, a2)) begin
      // ❌ Should not succeed: a2 is not a dog
      $display("❌ Unexpected cast success!");
    end else begin
      // ✅ This is the expected outcome
      $display("✅ Correctly failed to cast base Animal to Dog");
    end
  end

endmodule
