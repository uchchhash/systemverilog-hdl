`timescale 1ns/1ps
module fork_join;


    initial begin
        fork
        automatic int x = 10;
        begin
            for(int i =0; i<5; i++) begin
                #10; $display("@[%0t] i = %0d || x = %0d", $time, i, x);
                x = x+2;
            end
        end
        begin
            for(int j =0; j<5; j++) begin
                #5; $display("@[%0t] j = %0d || x = %0d", $time, j, x);
                x = x+2;
            end
        end
        join
    end

// Variable 'x' is implicitly static. You must either explicitly declare it as static or automatic
// or remove the initialization in the declaration of variable.

endmodule