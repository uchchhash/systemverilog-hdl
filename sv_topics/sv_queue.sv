//======================================================//
//=========== Queue Operations in SystemVerilog =========//
//======================================================//

// Queue syntax:
// [data_type] [name_of_queue][$]        -> Unbounded Queue
// [data_type] [name_of_queue][$:N]      -> Bounded Queue (max N+1 elements)

// This module demonstrates various queue operations such as:
// - Creation of bounded and unbounded queues
// - Inserting and deleting elements at specific indices
// - Accessing elements
// - Displaying the queue contents
// - Pushing/popping at front/back

module test;

    // Declare a bounded queue of integers with max size 11 (index range 0–10)
    int bounded_queue [$:10];

    // Declare an unbounded queue of integers
    int unbounded_queue [$];

    initial begin
        //-------------------------------------------------------------//
        // Populate the bounded queue with initial values
        //-------------------------------------------------------------//
        // NOTE: If more than 11 items are pushed, bounded queue overflows
        bounded_queue = {0, 1, 2, 5, 4, 7, 8, 4, 1, 2};
        $display("Initial bounded_queue = %p", bounded_queue);

        //-------------------------------------------------------------//
        // Insert value 7 at index 3
        //-------------------------------------------------------------//
        // Elements from index 3 onward will shift right by one
        // Resulting queue: {0, 1, 2, 7, 5, 4, 7, 8, 4, 1, 2}
        bounded_queue.insert(3, 7);
        $display("After insert(3,7): bounded_queue = %p", bounded_queue);

        //-------------------------------------------------------------//
        // Delete element at index 8
        //-------------------------------------------------------------//
        // Element at index 8 is removed and remaining elements shift left
        // Before deletion: index 8 = 4
        // Resulting queue: {0, 1, 2, 7, 5, 4, 7, 8, 1, 2}
        bounded_queue.delete(8);
        $display("After delete(8): bounded_queue = %p", bounded_queue);

        //-------------------------------------------------------------//
        // Demonstrate push_back() and push_front() on unbounded queue
        //-------------------------------------------------------------//
        unbounded_queue.push_back(100);
        unbounded_queue.push_back(200);
        unbounded_queue.push_front(50);
        $display("After push operations: unbounded_queue = %p", unbounded_queue);

        //-------------------------------------------------------------//
        // Demonstrate pop_front() and pop_back()
        //-------------------------------------------------------------//
        unbounded_queue.pop_front(); // removes 50
        unbounded_queue.pop_back();  // removes 200
        $display("After pop operations: unbounded_queue = %p", unbounded_queue);

        //-------------------------------------------------------------//
        // Get size of the queues
        //-------------------------------------------------------------//
        $display("Size of bounded_queue = %0d", bounded_queue.size());
        $display("Size of unbounded_queue = %0d", unbounded_queue.size());
    end

endmodule
