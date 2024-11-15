module streaming_operator_example;

    // Define a simple structure
    typedef struct {
        byte byte1;
        byte byte2;
        bit [3:0] nibble;
    } DataPacket;

    
    // Declare variables for the packet, bitstream, and received packet
    DataPacket packet, packet_out;
    typedef bit [19:0] bitstream;
    bitstream bitstream_data;

    // Standard SV data type (integer)
    int my_int = 32'h12345678;
    
    // Simulating a sequence of bits (bitstream)
    bitstream stream_data;

    // Declare the byte at the top before the statements to avoid the illegal declaration error
    byte my_byte;
    
    initial begin
        // Initialize the packet
        packet.byte1 = 8'hFF;
        packet.byte2 = 8'hAA;
        packet.nibble = 4'b1010;

        // Statement 1: Operate on a sequence of bits under user-specified order
        // Convert struct to bitstream (user can specify order)
        bitstream_data = bitstream'(packet); // Explicit cast to bitstream
        $display("Original Bitstream: %b", bitstream_data);
        
        // Manipulate the bitstream as a sequence of bits (user-defined order)
        bitstream_data = bitstream_data ^ 32'hF0F0F0F0;  // XOR operation (operation on bits)
        $display("Modified Bitstream (after XOR): %b", bitstream_data);

        // Convert the modified bitstream back to the struct
        packet_out = DataPacket'(bitstream_data);
        $display("Modified Packet: byte1=%h, byte2=%h, nibble=%b", packet_out.byte1, packet_out.byte2, packet_out.nibble);

        // Statement 2: Operate standard SV data types into a bit stream
        // Attempting to directly convert a standard SV data type (int) into bitstream
        // This causes an error: Cannot cast directly from int to bitstream
        // stream_data = bitstream'(my_int); // This line would fail compilation
        
        // Instead, casting my_int into a compatible bitstream (example would work if casted to a byte or packed type)
        my_byte = 8'h55; // Assign a value to my_byte
        stream_data = bitstream'(my_byte); // This works as byte is a valid bitstream type
        $display("Bitstream from byte: %b", stream_data);

        // Statement 3: Locate bit sequences representing SV standard types
        // Attempting to locate bit sequences (this is not the correct usage of streaming operators)
        // streaming operators do not automatically locate bit sequences; the user defines the sequence explicitly
        // For instance, this is how you cast and manipulate explicitly defined bitstream sequences
        // There is no "bit sequence locator" involved in this example

        // Let's display the final result
        $display("Final Packet: byte1=%h, byte2=%h, nibble=%b", packet_out.byte1, packet_out.byte2, packet_out.nibble);
    end

endmodule
