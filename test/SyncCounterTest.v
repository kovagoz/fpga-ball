`include "TestBench.v"
`include "SyncCounter.v"
`include "VgaTiming.v"

module SyncCounterTest();

  `INIT_TEST

  integer i;

  reg        clk = 0;
  wire [9:0] hpos;
  wire [9:0] vpos;

  SyncCounter uut(.i_Clk(clk), .o_HPos(hpos), .o_VPos(vpos));

  initial begin
    // Scan a little bit more than a whole frame
    for (i = 0; i < `H_MAX * `V_MAX * 2 + `H_MAX + 100; i = i + 1) begin
      #20 clk = ~clk;
    end
  end

endmodule
