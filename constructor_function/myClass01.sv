// ========================================================
// Example: Basic Custom UVM Component with Constructor Log
// ========================================================

// This class demonstrates how to define a custom UVM component
// and explore its `name`, `parent`, `get_full_name()`, and `get_type_name()`
// during construction.

class my_component extends uvm_component;

  // --------------------------------------------
  // Constructor for my_component
  // Arguments:
  //   - name:       Instance name of the component
  //   - parent:     Parent component handle (can be null for top-level)
  //
  // Behavior:
  //   - Calls super.new(name, parent) to properly register
  //   - Displays full name and type name using SystemVerilog $display
  // --------------------------------------------
  function new(string name, uvm_component parent);
    // Required call to base class constructor
    super.new(name, parent);

    // Print the full hierarchical name of this component
    $display("my_component created with full name: %s", get_full_name());

    // Print the registered type name of this component
    $display("my_component created with type name: %s", get_type_name());
  endfunction

endclass
