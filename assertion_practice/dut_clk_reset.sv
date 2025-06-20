module clk_otp_100k_module (
    output reg out,
    input wire clk_osc_50MHz,      // Use a faster clock as input
    input wire [1:0] mode,
    input wire soft_reset,
    input wire porz
);

  parameter DIVISOR = 250; // 50MHz / (2 * 250) = 100kHz

  integer count;

  always @(posedge clk_osc_50MHz or negedge porz) begin
    if (!porz) begin
      count <= 0;
      out <= 0;
    end else if (soft_reset || mode == 2'b00) begin
      out <= 0;
      count <= 0;
    end else begin
      if (count == DIVISOR - 1) begin
        out <= ~out;
        count <= 0;
      end else begin
        count <= count + 1;
      end
    end
  end

endmodule
