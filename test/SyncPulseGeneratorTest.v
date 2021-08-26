`include "TestBench.v"
`include "SyncPulseGenerator.v"
`include "VgaTiming.v"

module SyncPulseGeneratorTest();

  `INIT_TEST

  reg [9:0] hpos;
  reg [9:0] vpos;

  wire hsync;
  wire vsync;

  SyncPulseGenerator uut(.i_HPos(hpos), .i_VPos(vpos), .o_HSync(hsync), .o_VSync(vsync));

  initial begin
    for (vpos = 1; vpos <= `V_MAX + 2; vpos = vpos + 1) begin
      for (hpos = 1; hpos <= `H_MAX; hpos = hpos + 1) begin
        #40; // Wait for a whole clock cycle
      end
    end
  end

endmodule
