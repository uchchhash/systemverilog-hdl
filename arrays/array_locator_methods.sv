module test;

  // ================================================
  // Example 1: Locator methods on an integer array
  // ================================================

  // Fixed-size array with 10 integer elements
  int arr[10] = '{5, 1, 5, 7, 8, 9, 9, 10, 11, 15};

  // Dynamic arrays and scalars to hold results
  int result_ints[$];  // dynamic array to hold list results
  int single_value;    // scalar to hold single values

  initial begin
    // find(): Returns all values in arr equal to 5
    result_ints = arr.find(x) with (x == 5);
    $display("find(x == 5)           => %p", result_ints);  // Output: [5, 5]

    // find_index(): Returns indices where value is greater than 5
    result_ints = arr.find_index(x) with (x > 5);
    $display("find_index(x > 5)      => %p", result_ints);  // Output: [3, 4, 5, 6, 7, 8, 9]

    // find_first(): Returns the first value in arr equal to 9
    single_value = arr.find_first(x) with (x == 9);
    $display("find_first(x == 9)     => %0d", single_value);  // Output: 9

    // find_first_index(): Returns index of first element greater than 5
    single_value = arr.find_first_index(x) with (x > 5);
    $display("find_first_index(x>5)  => %0d", single_value);  // Output: 3

    // find_last(): Returns the last value in arr equal to 9
    single_value = arr.find_last(x) with (x == 9);
    $display("find_last(x == 9)      => %0d", single_value);  // Output: 9

    // find_last_index(): Returns index of last element equal to 9
    single_value = arr.find_last_index(x) with (x == 9);
    $display("find_last_index(x==9)  => %0d", single_value);  // Output: 6
  end

  // ================================================
  // Example 2: min, max, unique, unique_index
  // ================================================

  // New integer array with duplicates
  int arr2[10] = '{25, 15, 50, 70, 15, 99, 19, 10, 10, 15};

  initial begin
    // min(): Returns minimum value in arr2
    single_value = arr2.min();
    $display("min()                  => %0d", single_value);  // Output: 10

    // max(): Returns maximum value in arr2
    single_value = arr2.max();
    $display("max()                  => %0d", single_value);  // Output: 99

    // unique(): Returns elements with unique values, in first occurrence order
    result_ints = arr2.unique();
    $display("unique()               => %p", result_ints);  // Output: [25, 15, 50, 70, 99, 19, 10]

    // unique() with condition: elements greater than 20
    result_ints = arr2.unique(item) with (item > 20);
    $display("unique(item > 20)      => %p", result_ints);  // Output: [25, 50, 70, 99]

    // unique_index(): Returns indices of first unique values
    result_ints = arr2.unique_index();
    $display("unique_index()         => %p", result_ints);  // Output: [0, 1, 2, 3, 5, 6, 7]
  end

endmodule
