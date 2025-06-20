// ====================================================
// Example: Deep Copy vs. Shallow Copy in SystemVerilog
// ====================================================

// This is a helper class to simulate nested reference-type members
class id_class;

  int id;

  // Constructor
  function new(int id);
    this.id = id;
  endfunction

endclass



// This is the main packet class
class pkt_class;

  int addr;
  int data;
  id_class idc; // A reference-type field (class handle)

  // Constructor
  function new(int addr, int data, int id);
    this.addr = addr;
    this.data = data;
    this.idc = new(id); // Create a new nested id_class object
  endfunction

  // Task to display values of the object
  task display(string label);
    $display("[%s] addr = %0d, data = %0d, id = %0d", label, addr, data, idc.id);
  endtask

  // ----------------------------
  // Method to perform deep copy
  // ----------------------------
  // This method returns a completely new object with copied values
  // INCLUDING a new instance of the nested class (id_class)
  function pkt_class deep_copy();
    pkt_class new_pkt;
    new_pkt = new(this.addr, this.data, this.idc.id); // clone all values
    return new_pkt;
  endfunction

endclass



// ----------------------
// Top-level test module
// ----------------------
module tb;

  pkt_class pc1, pc2, pc3; // Declare handles for packet objects

  initial begin

    // Create an original object
    pc1 = new(10, 20, 1);

    // ------------------------------------------
    // Shallow Copy: just copies the object handle
    // pc2 and pc1 now point to the same object!
    // So, any changes via pc2 also affect pc1
    // ------------------------------------------
    pc2 = new pc1;

    // ------------------------------------------
    // Deep Copy: creates a new object with copied fields
    // A completely new object, with its own id_class
    // ------------------------------------------
    pc3 = pc1.deep_copy();

    // -------------------------
    // Print initial values
    // -------------------------
    $display("\n--- Initial Object States ---");
    pc1.display("pc1");
    pc2.display("pc2 (shallow copy)");
    pc3.display("pc3 (deep copy)");

    // -----------------------------------------------------
    // Modify the shallow copy (pc2) and observe that pc1 is affected
    // This is because both pc1 and pc2 point to the same id_class instance
    // -----------------------------------------------------
    pc2.addr = 100;
    pc2.data = 200;
    pc2.idc.id = 300; // Changing nested object value

    $display("\n--- After Modifying pc2 (Shallow Copy) ---");
    pc1.display("pc1 (affected!)");
    pc2.display("pc2");

    // -----------------------------------------------------
    // Modify the deep copy (pc3) and observe that pc1 is NOT affected
    // Because pc3 is a fully independent object
    // -----------------------------------------------------
    pc3.addr = 999;
    pc3.data = 888;
    pc3.idc.id = 777;

    $display("\n--- After Modifying pc3 (Deep Copy) ---");
    pc1.display("pc1 (still affected by pc2, but not pc3)");
    pc3.display("pc3 (independent)");
  end

endmodule
// ====================================================
// Example: Deep Copy vs. Shallow Copy in SystemVerilog
// ====================================================

// This is a helper class to simulate nested reference-type members
class id_class;

  int id;

  // Constructor
  function new(int id);
    this.id = id;
  endfunction

endclass



// This is the main packet class
class pkt_class;

  int addr;
  int data;
  id_class idc; // A reference-type field (class handle)

  // Constructor
  function new(int addr, int data, int id);
    this.addr = addr;
    this.data = data;
    this.idc = new(id); // Create a new nested id_class object
  endfunction

  // Task to display values of the object
  task display(string label);
    $display("[%s] addr = %0d, data = %0d, id = %0d", label, addr, data, idc.id);
  endtask

  // ----------------------------
  // Method to perform deep copy
  // ----------------------------
  // This method returns a completely new object with copied values
  // INCLUDING a new instance of the nested class (id_class)
  function pkt_class deep_copy();
    pkt_class new_pkt;
    new_pkt = new(this.addr, this.data, this.idc.id); // clone all values
    return new_pkt;
  endfunction

endclass



// ----------------------
// Top-level test module
// ----------------------
module tb;

  pkt_class pc1, pc2, pc3; // Declare handles for packet objects

  initial begin

    // Create an original object
    pc1 = new(10, 20, 1);

    // ------------------------------------------
    // Shallow Copy: just copies the object handle
    // pc2 and pc1 now point to the same object!
    // So, any changes via pc2 also affect pc1
    // ------------------------------------------
    pc2 = new pc1;

    // ------------------------------------------
    // Deep Copy: creates a new object with copied fields
    // A completely new object, with its own id_class
    // ------------------------------------------
    pc3 = pc1.deep_copy();

    // -------------------------
    // Print initial values
    // -------------------------
    $display("\n--- Initial Object States ---");
    pc1.display("pc1");
    pc2.display("pc2 (shallow copy)");
    pc3.display("pc3 (deep copy)");

    // -----------------------------------------------------
    // Modify the shallow copy (pc2) and observe that pc1 is affected
    // This is because both pc1 and pc2 point to the same id_class instance
    // -----------------------------------------------------
    pc2.addr = 100;
    pc2.data = 200;
    pc2.idc.id = 300; // Changing nested object value

    $display("\n--- After Modifying pc2 (Shallow Copy) ---");
    pc1.display("pc1 (affected!)");
    pc2.display("pc2");

    // -----------------------------------------------------
    // Modify the deep copy (pc3) and observe that pc1 is NOT affected
    // Because pc3 is a fully independent object
    // -----------------------------------------------------
    pc3.addr = 999;
    pc3.data = 888;
    pc3.idc.id = 777;

    $display("\n--- After Modifying pc3 (Deep Copy) ---");
    pc1.display("pc1 (still affected by pc2, but not pc3)");
    pc3.display("pc3 (independent)");
  end

endmodule
