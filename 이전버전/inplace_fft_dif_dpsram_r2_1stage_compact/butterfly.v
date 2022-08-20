module butterfly #(
    parameter COMP_BW = 32
)(
    input signed  [COMP_BW-1:0] G,H,
    output signed [COMP_BW+1:0] T,Y
);

parameter BW = COMP_BW/2;

wire [BW-1:0] Gr, Gi, Hr, Hi;
wire [BW:0]   Tr, Ti, Yr, Yi;

assign Gr = G[COMP_BW-1: BW];
assign Gi = G[BW-1: 0];
assign Hr = H[COMP_BW-1: BW];
assign Hi = H[BW-1: 0];

assign Tr = Gr+Hr;
assign Ti = Gi+Hi;
assign Yr = Gr-Hr;
assign Yi = Gi-Hi;

assign T = {Tr, Ti};
assign Y = {Yr, Yi};

endmodule

// BF #(BW) BF_inst(signals...) 형태로 사용