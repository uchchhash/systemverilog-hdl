
module array_queue;

    // Copy dynamic array to queue and vice versa
    // array and queue elements needs to be of same type

	byte myArray [];
    byte myArray2 [5];
    int myQueue [$:4];

	initial begin
		myArray = new [5];
		myArray2 = '{31, 67, 10, 4, 32'hAABBCCDD};
		foreach (myArray2[i])
			$display ("myArray[%0d] = %0h", i, myArray2[i]);
        //myQueue = myArray2;
        foreach (myArray2[i])begin
            myQueue.push_front(myArray2[i]);
        end
        $display ("myQueue = %p", myQueue);
        foreach (myArray2[i])begin
            myArray[i] = myArray2[i];
            $display ("myArray[%0d] = %0h", i, myArray[i]);
        end
	end


endmodule