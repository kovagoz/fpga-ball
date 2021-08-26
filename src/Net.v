`include "VgaTiming.v"

`define NET_WIDTH 4
`define NET_BEG (`H_VISIBLE_AREA - `NET_WIDTH) / 2
`define NET_END (`H_VISIBLE_AREA + `NET_WIDTH) / 2

module Net(
  input [9:0] i_HSync_Pos,
  input [9:0] i_VSync_Pos,
  output      o_Video);

  assign o_Video = i_HSync_Pos > `NET_BEG
                && i_HSync_Pos <= `NET_END
                && ((i_VSync_Pos + 4) & 8);

endmodule
