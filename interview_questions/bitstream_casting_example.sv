module bitstream_casting_example;

    // Integral Types (Fixed number of bits)
    int int_val;           // 32-bit integer
    shortint shortint_val; // 16-bit short integer
    byte byte_val;         // 8-bit byte

    // Packed Types (Arrays and Structures)
    logic [7:0] packed_array[4];  // Packed array of 4 bytes (32 bits)
    typedef struct {
        shortint address;  // 16-bit address
        logic [3:0] code;  // 4-bit code
        byte command[2];    // Array of 2 bytes (16 bits)
    } Control;
    Control ctrl_packet;     // Control packet (structure)

    // String Type (Dynamically sized array of bytes)
    string str_val;          // String type

    // Unpacked Arrays (Queue and Dynamic Arrays)
    byte dynamic_array[];    // Dynamically sized array of bytes
    byte unpacked_array[5];  // Fixed-size unpacked array of bytes
    byte queue unpacked_queue[$]; // Unpacked queue of bytes

    // Dynamically Sized Arrays (with dynamic size)
    byte dynamic_data[$];    // Dynamically sized array of bytes

    // Bit Stream Type (Packed bit array)
    typedef bit Bits[36:1];  // A 36-bit array to represent the bit stream

    // Queue of Bit Streams
    Bits bit_stream[$];      // Unpacked array of bit streams (queue)

    // Task to initialize and perform bit-stream casting
    task bit_stream_operations();
        // Integral Type Assignment
        int_val = 32'hA5A5A5A5;
        shortint_val = 16'hABCD;
        byte_val = 8'h5A;

        // Packed Type Assignment
        packed_array[0] = 8'h1F;
        packed_array[1] = 8'h2F;
        packed_array[2] = 8'h3F;
        packed_array[3] = 8'h4F;

        ctrl_packet.address = 16'h1234;
        ctrl_packet.code = 4'b1010;
        ctrl_packet.command[0] = 8'hAA;
        ctrl_packet.command[1] = 8'hBB;

        // String Type Assignment
        str_val = "Hello, Bit-Stream!";

        // Unpacked Array and Queue Assignment
        unpacked_array[0] = 8'h01;
        unpacked_array[1] = 8'h02;
        unpacked_array[2] = 8'h03;
        unpacked_array[3] = 8'h04;
        unpacked_array[4] = 8'h05;

        unpacked_queue.push_back(8'hA1);
        unpacked_queue.push_back(8'hB2);
        unpacked_queue.push_back(8'hC3);

        // Dynamic Arrays Assignment
        dynamic_array = new[5];
        dynamic_array[0] = 8'h1;
        dynamic_array[1] = 8'h2;
        dynamic_array[2] = 8'h3;
        dynamic_array[3] = 8'h4;
        dynamic_array[4] = 8'h5;

        // Bit-stream Casting Example: Converting Control Packet to Bit Stream
        bit_stream.push_back(Bits'(ctrl_packet));

        // Pop the bit stream and cast it back to Control type
        Control received_packet;
        received_packet = Control'(bit_stream.pop_front());

        // Print Results (for visualization)
        $display("Original Control Packet:");
        $display("Address: %h, Code: %b, Command[0]: %h, Command[1]: %h", ctrl_packet.address, ctrl_packet.code, ctrl_packet.command[0], ctrl_packet.command[1]);
        $display("Received Control Packet:");
        $display("Address: %h, Code: %b, Command[0]: %h, Command[1]: %h", received_packet.address, received_packet.code, received_packet.command[0], received_packet.command[1]);
    endtask

    // Initial block to run the task
    initial begin
        bit_stream_operations();  // Call task to perform operations
    end

endmodule
