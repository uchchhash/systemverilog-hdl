// ======================================================= //
// === SystemVerilog Array Sorting with Class Objects  === //
// ======================================================= //

// Forward declaration for the class (optional in this context)
typedef class register_class;

// Define the top-level module
module test;

  // Declare an array of class handles (4 elements)
  register_class rc[4];

  // String array for names
  string name_arr[4] = '{"google", "meta", "apple", "intel"};

  // Just an example array, not used in this demo
  int my_arr[6] = '{5, 4, 4, 8, 3, 7};

  initial begin
    // === Object construction and initialization ===
    foreach (rc[i]) begin
      rc[i] = new(name_arr[i]);    // Create new object with name
      rc[i].randomize();           // Randomize rank and pages
      rc[i].print();               // Print initial object state
    end

    $display("\n--- Sorted by name (alphabetically) ---");
    // === Sort the class array by name ===
    rc.sort(x) with (x.name);      // Sort by field `name` (lexicographically)
    foreach (rc[i]) rc[i].print();

    $display("\n--- Sorted by rank (numerically) ---");
    // === Sort the class array by rank ===
    rc.sort(x) with (x.rank);      // Sort by field `rank`
    foreach (rc[i]) rc[i].print();
  end

endmodule


// ======================================================= //
// === Definition of the register_class                  === //
// ======================================================= //

class register_class;

  // Class properties
  string name;          // Company name
  rand bit [3:0] rank;  // Random rank (0–15)
  rand bit [3:0] pages; // Random pages (0–15)

  // Constructor
  function new(string name);
    this.name = name;
  endfunction

  // Display function
  function void print();
    $display("@[%0t] Name = %s | Rank = %0d | Pages = %0d", $time, name, rank, pages);
  endfunction

endclass
