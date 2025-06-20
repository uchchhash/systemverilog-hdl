`timescale 1ns/1ps

// ========================================
//  Example: SystemVerilog User-Defined Nettype
// ========================================

module udn_example();

  // ============================================================
  // Step 1: Define a Struct Type (User-defined data type "U")
  // ============================================================

  typedef struct {
    real voltage;      // Voltage in volts
    real current;      // Current in amperes
    real resistance;   // Resistance in ohms
  } U;

  // ==================================================================
  // Step 2: Declare a Nettype Based on Struct "U"
  // This tells the simulator that 'U' will be used in a net context.
  // ==================================================================
  nettype U myNet;

  // Declare a net of type myNet (i.e., U)
  myNet n;

  // ==================================================================
  // Step 3: Use the net - Assign values to the net using a cast
  // ==================================================================
  assign n = U'{voltage: 1.8, current: 0.5, resistance: 100.0};

  // ==================================================================
  // Step 4: Monitor the values inside the user-defined net over time
  // ==================================================================
  initial begin
    $display("@[%0t] Assigning values to User-Defined-Net", $realtime);
    #10ns;
    $display("@[%0t] n = %p", $realtime, n);  // print the whole struct
    #10ns;
    $display("[%0t] n.voltage = %0.2f V, n.current = %0.2f A, n.resistance = %0.2f Ω", 
              $realtime, n.voltage, n.current, n.resistance);
  end

endmodule
