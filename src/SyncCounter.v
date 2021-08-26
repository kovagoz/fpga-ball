`include "VgaTiming.v"

module SyncCounter(
  input           i_Clk,
  output reg[9:0] o_HPos = 1,
  output reg[9:0] o_VPos = 1
);

  always @(posedge i_Clk) begin
    if (o_HPos == `H_MAX) begin
      o_HPos <= 1;

      if (o_VPos == `V_MAX) begin
        o_VPos <= 1;
      end else begin
        o_VPos <= o_VPos + 1;
      end
    end else begin
      o_HPos <= o_HPos + 1;
    end
  end

endmodule
