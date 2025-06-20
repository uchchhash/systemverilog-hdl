module test;

  // Declare a static array of 10 integers with some duplicates
  int arr[10] = '{5, 1, 5, 7, 8, 9, 9, 10, 11, 15};

  // ================================================
  // Demonstrate array ordering methods
  // ================================================
  // Available methods:
  // - reverse()   : Reverses the array elements
  // - sort()      : Sorts array elements in ascending order
  // - rsort()     : Sorts array elements in descending order
  // - shuffle()   : Randomly shuffles the array elements
  // ================================================

  initial begin
    // Original array
    $display("Original array          => %p", arr);

    // Reverse the array (in-place)
    arr.reverse();
    $display("After reverse()         => %p", arr);

    // Sort the array in ascending order
    arr.sort();
    $display("After sort()            => %p", arr);

    // Sort the array in descending order
    arr.rsort();
    $display("After rsort()           => %p", arr);

    // Shuffle the array randomly
    arr.shuffle();
    $display("After shuffle()         => %p", arr);
  end

endmodule
