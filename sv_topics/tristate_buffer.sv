//===============================================================
// SystemVerilog I2C Slave Example using Open-Drain Bus Logic
//===============================================================
// Objective:
// - Model the I2C 'sda' line with open-drain behavior
// - Multiple devices may drive the same 'sda' line
// - Any device can pull 'sda' LOW (drive 0), but none can drive it HIGH
// - Releasing the line means driving it to 'Z' (high impedance)
//
// This is achieved via tri-state assignments and 'inout' ports.
//===============================================================


// What This Code Demonstrates:
// Open-Drain Bus: Multiple drivers sharing one wire (sda), each allowed to pull low or release, but never drive high.

// Tri-State Logic: Uses conditional assign sda = ... ? 0 : z; to control open-drain behavior.

// Monitoring: Each slave logs what it sees on the bus, whether or not it is actively driving it.

// Pull-Up: Optional pullup(sda) models weak pull-up behavior found in real I2C hardware.

// Simulation Control: Using enable and drive_low signals to control which slave is active.


module i2cSlave #(parameter string NAME = "S") (
    inout wire sda,        // Open-drain data line (shared among devices)
    input wire scl,        // Clock line (for completeness)
    input wire enable,     // Enable driving from this slave (for simulation control)
    input wire drive_low   // Drive 0 if asserted, else release (Z)
);

    // Internal signal used to determine what this slave drives on SDA
    wire sdaOut;

    // Assign open-drain behavior:
    // If drive_low is asserted and slave is enabled => pull line LOW
    // Else => release the line (Z state)
    assign sda = (enable && drive_low) ? 1'b0 : 1'bz;

    // Monitor current value of the SDA line (driven by others or pulled up)
    wire sdaIn = sda;

    always @(sdaIn or drive_low) begin
        $display("[%0t][%s] SDA Value Seen: %b | Drive Low: %b", $time, NAME, sdaIn, drive_low);
    end

endmodule


//===============================================================
// Testbench
//===============================================================
module tb;

    // Shared open-drain I2C bus lines
    wire sda;
    logic scl = 0; // Not used in logic here, but included for completeness

    // Control signals for simulation
    logic s1_en = 0, s2_en = 0;
    logic s1_drv = 0, s2_drv = 0;

    // Instantiate two I2C slaves sharing the same bus
    i2cSlave #("Slave1") slave1 (
        .sda(sda),
        .scl(scl),
        .enable(s1_en),
        .drive_low(s1_drv)
    );

    i2cSlave #("Slave2") slave2 (
        .sda(sda),
        .scl(scl),
        .enable(s2_en),
        .drive_low(s2_drv)
    );

    // Pull-up resistor simulation:
    // If no one drives sda (all Z), sda pulls high
    pullup(sda); // Optional: Models weak pull-up as seen in real I2C buses

    // Simulation sequence
    initial begin
        $display("\n==== I2C Open-Drain Bus Simulation ====\n");

        // Initial state: all devices released the bus
        #10;
        s1_en = 1; s1_drv = 0; // Enable slave1 but not driving (Z)
        s2_en = 1; s2_drv = 0; // Enable slave2 but not driving (Z)

        #10;
        s1_drv = 1; // Slave1 drives SDA LOW
        #10;
        s1_drv = 0; // Slave1 releases the line

        #10;
        s2_drv = 1; // Slave2 drives SDA LOW
        #10;
        s2_drv = 0; // Slave2 releases the line

        #10;
        s1_en = 0; s2_en = 0; // Disable both
        #10;

        $display("\n==== Simulation Complete ====\n");
        $finish;
    end

endmodule
