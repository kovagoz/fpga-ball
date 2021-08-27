`include "VgaTiming.v"

module HitDetector(
  input  i_Clk,
  input  i_Ball_Video,
  input  i_HBlank,
  input  i_HReset,
  input  i_VReset,
  output o_Hit);

  reg hit = 0;

  always @(posedge i_Clk) begin
    // Hits the left wall
    if (i_Ball_Video && (i_HReset || i_HBlank)) begin
      hit <= 1;
    end

    // Hits the right wall
    if (i_VReset) begin
      hit <= 0;
    end
  end

  assign o_Hit = hit;

endmodule
