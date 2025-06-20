// ==========================================================
// 📘 SystemVerilog: Class Inheritance, Constructor, Casting
// Includes:
//  - myClass01 (Base class)
//  - myClass02 (Derived class)
//  - Demonstrates upcasting and downcasting using $cast
// ==========================================================

`timescale 1ns/1ps

// --------------------------------------------
// ✅ Base Class: myClass01
// --------------------------------------------
class myClass01;

  // Data Members
  int a1 = 10;
  bit b1;
  logic c1;

  // Constructor
  function new(int a);
    a1 = a;
    $display("=====>> [myClass01] Constructed with a1 = %0d", a1);
  endfunction

  // Display task
  task display_vals();
    $display("=====>> [myClass01] a1 = %0d | b1 = %0d | c1 = %0d", a1, b1, c1);
  endtask

endclass

// --------------------------------------------
// ✅ Derived Class: myClass02
// Inherits from myClass01
// --------------------------------------------
class myClass02 extends myClass01;

  int a2 = 5;
  bit b2;
  logic c2;

  // Constructor
  function new();
    super.new(a2);  // Calls base constructor with a2
    $display("=====>> [myClass02] Constructed with inherited a1 = %0d", a1);
  endfunction

  // New display method (calls base version)
  task display_vals2();
    display_vals();  // Calls base class display_vals()
    $display("=====>> [myClass02] a2 = %0d | b2 = %0d | c2 = %0d", a2, b2, c2);
  endtask

endclass

// --------------------------------------------
// ✅ Top-Level Module for Testing
// --------------------------------------------
module myModule;

  myClass02 derived_obj;       // Derived class handle
  myClass01 base_handle;       // Base class handle

  initial begin
    $display("\n=====>> Simulation Started <<=====\n");

    // 🔹 Instantiate the derived class object
    derived_obj = new();
    derived_obj.b1 = 1;  // base member
    derived_obj.b2 = 0;  // derived member

    // 🔹 Upcasting: derived_obj -> base_handle
    base_handle = derived_obj;
    $display("=====>> Upcasting done (derived → base)");

    // 🔹 Call base class method through base handle
    base_handle.display_vals();  // Will call base version

    // 🔹 Downcasting: base_handle -> derived_handle
    myClass02 downcast_obj;
    if ($cast(downcast_obj, base_handle)) begin
      $display("=====>> Downcasting successful (base → derived)");
      downcast_obj.display_vals2(); // Call derived class method
    end else begin
      $display("=====>> Downcasting failed!");
    end

    $display("\n=====>> Simulation Completed <<=====\n");
    $finish;
  end

endmodule
// ==========================================================
// 📘 SystemVerilog: Class Inheritance, Constructor, Casting
// Includes:
//  - myClass01 (Base class)
//  - myClass02 (Derived class)
//  - Demonstrates upcasting and downcasting using $cast
// ==========================================================

`timescale 1ns/1ps

// --------------------------------------------
// ✅ Base Class: myClass01
// --------------------------------------------
class myClass01;

  // Data Members
  int a1 = 10;
  bit b1;
  logic c1;

  // Constructor
  function new(int a);
    a1 = a;
    $display("=====>> [myClass01] Constructed with a1 = %0d", a1);
  endfunction

  // Display task
  task display_vals();
    $display("=====>> [myClass01] a1 = %0d | b1 = %0d | c1 = %0d", a1, b1, c1);
  endtask

endclass

// --------------------------------------------
// ✅ Derived Class: myClass02
// Inherits from myClass01
// --------------------------------------------
class myClass02 extends myClass01;

  int a2 = 5;
  bit b2;
  logic c2;

  // Constructor
  function new();
    super.new(a2);  // Calls base constructor with a2
    $display("=====>> [myClass02] Constructed with inherited a1 = %0d", a1);
  endfunction

  // New display method (calls base version)
  task display_vals2();
    display_vals();  // Calls base class display_vals()
    $display("=====>> [myClass02] a2 = %0d | b2 = %0d | c2 = %0d", a2, b2, c2);
  endtask

endclass

// --------------------------------------------
// ✅ Top-Level Module for Testing
// --------------------------------------------
module myModule;

  myClass02 derived_obj;       // Derived class handle
  myClass01 base_handle;       // Base class handle

  initial begin
    $display("\n=====>> Simulation Started <<=====\n");

    // 🔹 Instantiate the derived class object
    derived_obj = new();
    derived_obj.b1 = 1;  // base member
    derived_obj.b2 = 0;  // derived member

    // 🔹 Upcasting: derived_obj -> base_handle
    base_handle = derived_obj;
    $display("=====>> Upcasting done (derived → base)");

    // 🔹 Call base class method through base handle
    base_handle.display_vals();  // Will call base version

    // 🔹 Downcasting: base_handle -> derived_handle
    myClass02 downcast_obj;
    if ($cast(downcast_obj, base_handle)) begin
      $display("=====>> Downcasting successful (base → derived)");
      downcast_obj.display_vals2(); // Call derived class method
    end else begin
      $display("=====>> Downcasting failed!");
    end

    $display("\n=====>> Simulation Completed <<=====\n");
    $finish;
  end

endmodule
// ==========================================================
// 📘 SystemVerilog: Class Inheritance, Constructor, Casting
// Includes:
//  - myClass01 (Base class)
//  - myClass02 (Derived class)
//  - Demonstrates upcasting and downcasting using $cast
// ==========================================================

`timescale 1ns/1ps

// --------------------------------------------
// ✅ Base Class: myClass01
// --------------------------------------------
class myClass01;

  // Data Members
  int a1 = 10;
  bit b1;
  logic c1;

  // Constructor
  function new(int a);
    a1 = a;
    $display("=====>> [myClass01] Constructed with a1 = %0d", a1);
  endfunction

  // Display task
  task display_vals();
    $display("=====>> [myClass01] a1 = %0d | b1 = %0d | c1 = %0d", a1, b1, c1);
  endtask

endclass

// --------------------------------------------
// ✅ Derived Class: myClass02
// Inherits from myClass01
// --------------------------------------------
class myClass02 extends myClass01;

  int a2 = 5;
  bit b2;
  logic c2;

  // Constructor
  function new();
    super.new(a2);  // Calls base constructor with a2
    $display("=====>> [myClass02] Constructed with inherited a1 = %0d", a1);
  endfunction

  // New display method (calls base version)
  task display_vals2();
    display_vals();  // Calls base class display_vals()
    $display("=====>> [myClass02] a2 = %0d | b2 = %0d | c2 = %0d", a2, b2, c2);
  endtask

endclass

// --------------------------------------------
// ✅ Top-Level Module for Testing
// --------------------------------------------
module myModule;

  myClass02 derived_obj;       // Derived class handle
  myClass01 base_handle;       // Base class handle

  initial begin
    $display("\n=====>> Simulation Started <<=====\n");

    // 🔹 Instantiate the derived class object
    derived_obj = new();
    derived_obj.b1 = 1;  // base member
    derived_obj.b2 = 0;  // derived member

    // 🔹 Upcasting: derived_obj -> base_handle
    base_handle = derived_obj;
    $display("=====>> Upcasting done (derived → base)");

    // 🔹 Call base class method through base handle
    base_handle.display_vals();  // Will call base version

    // 🔹 Downcasting: base_handle -> derived_handle
    myClass02 downcast_obj;
    if ($cast(downcast_obj, base_handle)) begin
      $display("=====>> Downcasting successful (base → derived)");
      downcast_obj.display_vals2(); // Call derived class method
    end else begin
      $display("=====>> Downcasting failed!");
    end

    $display("\n=====>> Simulation Completed <<=====\n");
    $finish;
  end

endmodule
