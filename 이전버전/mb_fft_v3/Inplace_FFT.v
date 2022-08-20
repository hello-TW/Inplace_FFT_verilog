module Inplace_FFT #(
    parameter BW = 16
)(
    input nrst, clk, start, valid,
    input [BW-1:0] inReal, inImag,
    output reg [BW-1:0]  outReal0, outImag0, outReal1, outImag1
);
    parameter complex_BW = 2*BW;
    wire input_done, output_start, swap0_en, swap1_en;
    wire we_b0, re_b0, we_b1, re_b1;
	
    wire [7:0] cnt;
    wire [4:0] waddr_b0, waddr_b1, raddr_b0, raddr_b1;
    
    wire [complex_BW-1:0] data_in_b0, data_in_b1;
    wire [complex_BW-1:0] data_out_b0, data_out_b1; 
    wire [complex_BW-1:0] swap0_up, swap0_lo;
    wire [complex_BW-1:0] mux0_in0, mux1_in0, mux0_in1, mux1_in1;
    wire [complex_BW-1:0] out_up, out_lo;
    
    wire [complex_BW+1:0] bf_up, bf_lo, swap1_up, swap1_lo, mult_out;

    counter counter_inst(nrst, clk, start, valid, cnt);

    simple_dualport_RAM #(complex_BW) bank0(clk, valid, we_b0, re_b0, waddr_b0, raddr_b0, data_in_b0, data_out_b0);
    simple_dualport_RAM #(complex_BW) bank1(clk, valid, we_b1, re_b1, waddr_b1, raddr_b1, data_in_b1, data_out_b1);

    swap #(complex_BW) swap0(swap0_en, data_out_b0, data_out_b1, swap0_up, swap0_lo);

    BF #(BW) butterfly(swap0_up[complex_BW-1:BW], swap0_up[BW-1:0], swap0_lo[complex_BW-1:BW], swap0_lo[BW-1:0], bf_up[complex_BW+1:BW+1], bf_up[BW:0], bf_lo[complex_BW+1:BW+1], bf_lo[BW:0]);
    MULT #(complex_BW+2) mult(clk, cnt, bf_lo, mult_out);
    
    swap #(complex_BW+2) swap1(swap1_en, bf_up, mult_out, swap1_up, swap1_lo);
    controlblock ctr(clk, valid, nrst, cnt, input_done, output_start,swap0_en, swap1_en, we_b0, re_b0, we_b1, re_b1, waddr_b0, raddr_b0, waddr_b1, raddr_b1);
// reordering vertex_coloring(cnt, bank_select);

// input mux
    assign data_in_b0 =  input_done? mux0_in1 : mux0_in0;
    assign data_in_b1 =  input_done? mux1_in1 : mux1_in0;
    assign mux1_in0 = {inReal,inImag};
    assign mux0_in0 = {inReal,inImag};

// bit slice
    assign mux0_in1 = {swap1_up[complex_BW+1], swap1_up[complex_BW-1 : BW+1],swap1_up[BW],swap1_up[BW-2:0]};
    assign out_up   = {swap1_up[complex_BW+1], swap1_up[complex_BW-1 : BW+1],swap1_up[BW],swap1_up[BW-2:0]};

    assign mux1_in1 = {swap1_lo[complex_BW+1], swap1_lo[complex_BW-1 : BW+1],swap1_lo[BW],swap1_lo[BW-2:0]};
    assign out_lo   = {swap1_lo[complex_BW+1], swap1_lo[complex_BW-1 : BW+1],swap1_lo[BW],swap1_lo[BW-2:0]};

//output reg
    always @(posedge clk) begin
        if(!nrst | !output_start ) begin
            {outReal0, outImag0} <= 0;
            {outReal1, outImag1} <= 0;
        end
        else  begin
            {outReal0, outImag0} <= out_up;
            {outReal1, outImag1} <= out_lo;
        end
    end


endmodule
