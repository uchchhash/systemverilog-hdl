module struct_example;
    // In SystemVerilog, struct elements can also be assigned individually or as a whole.
    // Structs in SystemVerilog are useful for grouping related data of various types.
    // Here's how struct assignment works in SystemVerilog:

    // Define a struct type called 'point_t'
    typedef struct packed {
      byte x; // Struct member 'x'
      logic [7:0] y; // Struct member 'y'
    } point_t;

    // Declare variables of type 'point_t'
    point_t p1, p2;


    initial begin
        // Explanation:
        // Individual Assignment: You can assign values to each member of a struct separately.
        p1.x = 10; // Assign value 10 to the 'x' member of struct p1
        p1.y = 20; // Assign value 20 to the 'y' member of struct p1

        $display("Point p1: (%0d, %0d)", p1.x, p1.y);

        // Whole Assignment: You can assign one struct to another of the same type, copying all members at once.
        // Assign values to all members at once using another struct
      //  p2 = '{30, 40}; // Initialize struct p2 with values for all members
        p2 = 16'hAAFF; // Initialize struct p2 with values for all members

      $display("Point p2: (%0h, %0h)", p2.x, p2.y);

        // Assign p2 to p1, copying all members
        p1 = p2; // Copy all member values from p2 to p1

        $display("After assignment, Point p1: (%0d, %0d)", p1.x, p1.y);
    end
endmodule
