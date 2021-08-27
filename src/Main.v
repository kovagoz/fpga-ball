`include "Vga.v"
`include "Ball.v"
`include "Net.v"

module Main(
  input  i_Clk,

  output o_VGA_HSync,
  output o_VGA_VSync,

  output o_VGA_Red_0,
  output o_VGA_Red_1,
  output o_VGA_Red_2,

  output o_VGA_Grn_0,
  output o_VGA_Grn_1,
  output o_VGA_Grn_2,

  output o_VGA_Blu_0,
  output o_VGA_Blu_1,
  output o_VGA_Blu_2);

  wire [9:0] w_HSync_Pos;
  wire [9:0] w_VSync_Pos;
  wire       w_Video_Ball;
  wire       w_Video_Net;

  Vga vga(
    .i_Clk(i_Clk),
    .i_Video(w_Video_Ball | w_Video_Net),

    .o_HSync(o_VGA_HSync),
    .o_VSync(o_VGA_VSync),

    .o_HPos(w_HSync_Pos),
    .o_VPos(w_VSync_Pos),

    .o_Red({ o_VGA_Red_0, o_VGA_Red_1, o_VGA_Red_2 }),
    .o_Green({ o_VGA_Grn_0, o_VGA_Grn_1, o_VGA_Grn_2 }),
    .o_Blue({ o_VGA_Blu_0, o_VGA_Blu_1, o_VGA_Blu_2 })
  );

  Ball ball(
    .i_Clk(i_Clk),
    .i_HSync_Pos(w_HSync_Pos),
    .i_VSync_Pos(w_VSync_Pos),
    .o_Video(w_Video_Ball)
  );

  Net net(
    .i_HSync_Pos(w_HSync_Pos),
    .i_VSync_Pos(w_VSync_Pos),
    .o_Video(w_Video_Net)
  );

endmodule
