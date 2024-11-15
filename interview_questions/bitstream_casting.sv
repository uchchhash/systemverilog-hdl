

module bitstream_casting;

    byte b0, b1, b2, b3;
    int var0, var1;

    initial begin
        b0 = 8'hAA;
        b1 = 8'hBB;
        b2 = 8'hCC;
        b3 = 8'hDD;
        var0 = {>>{b0,b1,b2,b3}};
        $display("var0 = %0h", var0);
        var1 = {<<{b0,b1,b2,b3}};
        $display("var1 = %0h", var1);
    end


endmodule