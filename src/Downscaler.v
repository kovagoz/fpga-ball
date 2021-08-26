module Downscaler(
  input  i_Clk,
  output o_Clk);

  parameter ratio = 2;

  reg [1:0] counter = 0;

  always @(negedge i_Clk) begin
    if (counter == ratio - 1)
      counter <= 0;
    else
      counter <= counter + 1;
  end

  assign o_Clk = (counter == 0);

endmodule
