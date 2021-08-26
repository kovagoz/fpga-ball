`include "SyncCounter.v"
`include "SyncPulseGenerator.v"
`include "VgaTiming.v"

// Make sure that the given coordinate is in the visible area of the screen
`define IS_VISIBLE(x, y) x <= `H_VISIBLE_AREA && y <= `V_VISIBLE_AREA

module Vga(
  input        i_Clk,
  input        i_Video, // 1bit (black & white) video input

  output       o_HSync,
  output       o_VSync,

  output [2:0] o_Red,
  output [2:0] o_Green,
  output [2:0] o_Blue,

  output [9:0] o_HPos,
  output [9:0] o_VPos);

  SyncCounter sc0(
    .i_Clk(i_Clk),
    .o_HPos(o_HPos),
    .o_VPos(o_VPos)
  );

  SyncPulseGenerator spg0(
    .i_HPos(o_HPos),
    .i_VPos(o_VPos),
    .o_HSync(o_HSync),
    .o_VSync(o_VSync)
  );

  // Convert B&W input to RGB
  assign o_Red   = (`IS_VISIBLE(o_HPos, o_VPos) && i_Video) ? -1 : 0;
  assign o_Green = (`IS_VISIBLE(o_HPos, o_VPos) && i_Video) ? -1 : 0;
  assign o_Blue  = (`IS_VISIBLE(o_HPos, o_VPos) && i_Video) ? -1 : 0;

endmodule
