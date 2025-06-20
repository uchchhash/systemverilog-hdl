module tb;

  // ============================================
  // ✅ Declare AHB Memory Array
  // Key:  11-bit address (1024 locations)
  // Data: 8-bit per location
  // ============================================
  bit [7:0] ahb_memory [bit[10:0]]; // associative array with 11-bit keys

  // AHB address register (32-bit wide, but only lower 11 bits used for indexing)
  bit [31:0] haddr;

  initial begin
    // Initialize address
    haddr = 0;

    // Loop over 1024 address locations (2^10)
    for (int i = 0; i < 2**10; i++) begin
      // Assign value to the memory at current address
      // You can use `$urandom` to populate with random data if desired
      ahb_memory[haddr[10:0]] = 8'hFF;  // or use $urandom % 256 for real randomness

      // Display the written value with timestamp
      $display("@[%0t] ahb_memory[%0h] = %0h", $time, haddr[10:0], ahb_memory[haddr[10:0]]);

      // Increment address
      haddr = haddr + 1;
    end
  end

endmodule
