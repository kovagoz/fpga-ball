`include "VgaTiming.v"

`define BALL_SIZE 10

`define VSYNC_NEGEDGE i_VSync_Pos == `V_PULSE_HEAD && i_HSync_Pos == 1
`define VSYNC_POSEDGE i_VSync_Pos == `V_PULSE_TAIL && i_HSync_Pos == `H_MAX

// Coordinates of walls around the playing field
`define TOP_WALL    1
`define BOTTOM_WALL `V_VISIBLE_AREA - `BALL_SIZE + 1

module Ball(
  input        i_Clk,
  input [9:0]  i_HSync_Pos,
  input [9:0]  i_VSync_Pos,
  input        i_Hit,
  output       o_Video);

  parameter p_STARTX = (`H_VISIBLE_AREA - `BALL_SIZE) / 2;
  parameter p_STARTY = (`V_VISIBLE_AREA - `BALL_SIZE) / 2;

  reg [9:0] xpos = p_STARTX;
  reg [9:0] ypos = p_STARTY;
  reg       xdir = 0;
  reg       ydir = 0;

  // Move ball horizontally
  always @(posedge i_Clk) begin
    if (`VSYNC_POSEDGE) begin
      xpos <= xpos + (xdir ? 1 : -1);
    end
  end

  // Set ball's horizontal direction
  always @(posedge i_Clk) begin
    if (`VSYNC_NEGEDGE && i_Hit) begin
      xdir <= 1 - xdir;
    end
  end

  // Move ball vertically
  always @(posedge i_Clk) begin
    if (`VSYNC_NEGEDGE) begin
      ypos <= ypos + (ydir ? 1 : -1);
    end
  end

  // Set ball's vertical direction
  always @(posedge i_Clk) begin
    if (`VSYNC_POSEDGE) begin
      if (ypos == `TOP_WALL || ypos == `BOTTOM_WALL) begin
        ydir <= 1 - ydir;
      end
    end
  end

  // Generate ball's video signal
  assign o_Video = i_HSync_Pos >= xpos && i_HSync_Pos < xpos + `BALL_SIZE
                && i_VSync_Pos >= ypos && i_VSync_Pos < ypos + `BALL_SIZE;

endmodule
