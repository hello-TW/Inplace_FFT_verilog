module BF (Gr,Gi,Hr,Hi,Xr,Xi,Yr,Yi);
parameter BW = 16;

input signed [BW-1:0] Gr,Gi,Hr,Hi;
output signed [BW:0] Xr,Xi,Yr,Yi;

assign Xr = Gr+Hr;
assign Xi = Gi+Hi;
assign Yr = Gr-Hr;
assign Yi = Gi-Hi;
//test
endmodule


// BF #(BW) BF_inst(signals...) 형태로 사용