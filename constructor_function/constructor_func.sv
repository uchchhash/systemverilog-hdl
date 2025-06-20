// ===========================================================
// UVM Testbench Example: Exploring uvm_component Constructor
// ===========================================================

// This example shows how the UVM component constructor works.
// It demonstrates:
//  - Top-level component creation (parent = null)
//  - Nested component instantiation using ::type_id::create()
//  - How get_full_name() and get_type_name() behave
//  - Proper use of `run_test()` and factory registration

`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;


// ===============================
// Base Test Class
// ===============================
class axi_base_test extends uvm_test;

  // Register class with UVM factory
  `uvm_component_utils(axi_base_test)

  // Constructor: default name "axi_base_test", parent is optional (null if top-level)
  function new(string name = "axi_base_test", uvm_component parent = null);
    super.new(name, parent);  // Required super call

    // Display messages using UVM macros
    `uvm_info(get_type_name(), "AXI Base Test Constructed", UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("Full Name: %s", get_full_name()), UVM_MEDIUM);
    `uvm_info(get_type_name(), $sformatf("Type Name: %s", get_type_name()), UVM_MEDIUM);
  endfunction

endclass : axi_base_test


// ===============================
// Derived Test Class 1
// ===============================
class axi_combination_test extends axi_base_test;

  // Register with factory
  `uvm_component_utils(axi_combination_test)

  // Constructor overrides base with new default name
  function new(string name = "axi_combination_test", uvm_component parent = null);
    super.new(name, parent);

    // Show component creation info
    `uvm_info(get_type_name(), "AXI Combination Test Constructed", UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("Full Name: %s", get_full_name()), UVM_MEDIUM);
    `uvm_info(get_type_name(), $sformatf("Type Name: %s", get_type_name()), UVM_MEDIUM);
  endfunction

endclass : axi_combination_test


// ===============================
// Derived Test Class 2 with Nested Child
// ===============================
class axi_combination_test2 extends axi_combination_test;

  // Register with factory
  `uvm_component_utils(axi_combination_test2)

  // Declare child component instance (will be created inside this class)
  axi_combination_test comb_test_1;

  // Constructor
  function new(string name = "axi_combination_test2", uvm_component parent = null);
    super.new(name, parent);

    // Log constructor info
    `uvm_info(get_type_name(), "AXI Combination Test-2 Constructed", UVM_NONE);
    `uvm_info(get_type_name(), $sformatf("Full Name: %s", get_full_name()), UVM_MEDIUM);
    `uvm_info(get_type_name(), $sformatf("Type Name: %s", get_type_name()), UVM_MEDIUM);

    // Create a child component using factory and set this class as its parent
    comb_test_1 = axi_combination_test::type_id::create("comb_test_1", this);
  endfunction

endclass : axi_combination_test2


// ===============================
// Top Module: Entry Point
// ===============================
module top;

  // Always use run_test() to instantiate UVM tests via factory
  // Change the argument below to run different test classes:
  // Options: "axi_base_test", "axi_combination_test", "axi_combination_test2"
  initial begin
    run_test("axi_combination_test2");
  end

endmodule
