`include "VgaTiming.v"

module SyncPulseGenerator(
  input [9:0] i_HPos,
  input [9:0] i_VPos,
  output      o_HSync,
  output      o_VSync);

  assign o_HSync = (i_HPos < `H_PULSE_HEAD) || (i_HPos > `H_PULSE_TAIL);
  assign o_VSync = (i_VPos < `V_PULSE_HEAD) || (i_VPos > `V_PULSE_TAIL);

endmodule
