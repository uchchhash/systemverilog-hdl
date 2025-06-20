`timescale 1ns/1ps

// ==============================================
// ✅ Include UVM Infrastructure
// ==============================================
// `uvm_macros.svh` provides UVM utility macros like `uvm_component_utils`, `run_test`, etc.
`include "uvm_macros.svh"
import uvm_pkg::*; // Import all UVM classes

// ==============================================
// ✅ Define a Custom UVM Component Class
// ==============================================
// This class will be used to explore constructor behavior.
// It logs the instance name, full hierarchical name, and type name.
class my_component extends uvm_component;

  // Required UVM macro to register the component with the factory
  `uvm_component_utils(my_component)

  // Constructor: creates an instance of this component
  // Arguments:
  //   - name: Leaf name of the instance
  //   - parent: Parent component in the hierarchy (null if top-level)
  function new(string name, uvm_component parent);
    // Always call the base class constructor first
    super.new(name, parent);

    // Log the leaf name passed to the constructor
    `uvm_info("MY_COMPONENT", 
      $sformatf("Constructed with leaf name      = %s", name), UVM_LOW);

    // Log the full hierarchical name computed by UVM
    `uvm_info("MY_COMPONENT", 
      $sformatf("Full hierarchical name         = %s", get_full_name()), UVM_LOW);

    // Log the registered type name of this component
    `uvm_info("MY_COMPONENT", 
      $sformatf("Component registered type name = %s", get_type_name()), UVM_LOW);
  endfunction

endclass : my_component


// ==============================================
// ✅ Define a Custom UVM Test Class
// ==============================================
// This test creates two components using different parent references
class my_test extends uvm_test;

  // Register this test with the UVM factory
  `uvm_component_utils(my_test)

  // Declare handles for the components
  my_component comp1; // Top-level child of this test
  my_component comp2; // Nested under comp1

  // Constructor for the test
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // ===========================================
  // Build Phase
  // ===========================================
  // Components should be created here using the factory
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // ✅ Create comp1 as a child of the current test component
    //    get_full_name() will show: uvm_test_top.comp1
    comp1 = my_component::type_id::create("comp1", this);

    // ✅ Create comp2 as a child of comp1
    //    get_full_name() will show: uvm_test_top.comp1.comp2
    comp2 = my_component::type_id::create("comp2", comp1);
  endfunction

endclass : my_test


// ==============================================
// ✅ Top-Level Module: Simulation Entry Point
// ==============================================
// UVM tests must be launched using `run_test()`
// This creates the test via the UVM factory and starts the simulation.
module top;

  initial begin
    // You can run any registered UVM test by name here
    // Make sure the name matches the class name used with `uvm_component_utils`
    run_test("my_test");
  end

endmodule
