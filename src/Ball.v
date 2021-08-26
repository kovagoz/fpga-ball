`include "VgaTiming.v"
`include "Downscaler.v"

`define BALL_SIZE 10

module Ball(
  input [9:0] i_HSync_Pos,
  input [9:0] i_VSync_Pos,
  input       i_VSync,
  output      o_Video);

  reg [9:0] xpos = (`H_VISIBLE_AREA - `BALL_SIZE) / 2;
  reg [9:0] ypos = (`V_VISIBLE_AREA - `BALL_SIZE) / 2;
  reg       xdir = 0;
  reg       ydir = 0;

  wire      w_VClock; // Clock signal for vertical movement

  // Move ball horizontally one pixel in every frame
  always @(negedge i_VSync) begin
    if (xpos == 1 || xpos == `H_VISIBLE_AREA - `BALL_SIZE + 1) begin
      xdir = 1 - xdir;
    end

    xpos = xpos + (xdir ? 1 : -1);
  end

  // Halve the frequency of the vertical sync signal to
  // slow down ball's vertical speed
  Downscaler #(2) dsc0(
    .i_Clk(i_VSync),
    .o_Clk(w_VClock)
  );

  // Move ball vertically one line in every second frame
  always @(posedge w_VClock) begin
    if (ypos == 1 || ypos == `V_VISIBLE_AREA - `BALL_SIZE + 1) begin
      ydir = 1 - ydir;
    end

    ypos = ypos + (ydir ? 1 : -1);
  end

  // Generate ball's video signal
  assign o_Video = i_HSync_Pos >= xpos && i_HSync_Pos < xpos + `BALL_SIZE
                && i_VSync_Pos >= ypos && i_VSync_Pos < ypos + `BALL_SIZE;

endmodule
