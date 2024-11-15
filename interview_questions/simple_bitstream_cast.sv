module bitstream_cast;

    typedef struct {
        bit [7:0] address;
        bit [7:0] payload [2];
    } packet;

    typedef bit [7:0] data_stream[$];
    packet pkt;
    data_stream stream;
    
    initial begin
        pkt.address = 10;
        pkt.payload[0] = 100;
        pkt.payload[1] = 200;
        $display("packet = %p", pkt);

        stream[0] = 8'b10101010;
        $display("stream = %p", stream);
        stream = { stream, data_stream'(pkt) };
        $display("stream = %p", stream);
    end


endmodule