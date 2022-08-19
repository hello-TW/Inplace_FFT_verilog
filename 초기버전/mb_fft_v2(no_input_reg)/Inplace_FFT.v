module Inplace_FFT #(
    parameter BW = 16
    
)(
    input nrst, clk, start,
    input valid,
    input [BW-1:0] inReal, inImag,
    output output_start,
    output reg[BW-1:0]  outReal0, outImag0, outReal1, outImag1
);
    parameter complex_BW = 2*BW;
    wire we_b0, re_b0, bank_select, input_done; 
    wire output_start_temp, bank_select_stage5;
	wire [7:0] cnt, cnt_temp;
    wire [4:0] waddr_b0, waddr_b1, raddr_b0, raddr_b1;
    wire [complex_BW-1:0] data_in_b0, data_in_b1;
    wire [complex_BW-1:0] data_out_b0, data_out_b1; 
    wire [complex_BW-1:0] swap0_up, swap0_lo;
    wire [complex_BW-1:0] mux0_in1, mux1_in1;
    wire [complex_BW-1:0] out_up, out_lo;
    
    wire [complex_BW+1:0] bf_up, bf_lo, swap1_up, swap1_lo, mult_out;
    reg  [complex_BW-1:0] mux0_in0, mux1_in0, temp_up, temp_lo;
    reg  [2:0] stage = 3'b111;
    reg  swap_en;

    counter counter_inst(nrst, clk, start, valid, cnt);

    simple_dualport_RAM #(complex_BW) bank0(clk, valid, we_b0, re_b0, waddr_b0, raddr_b0, data_in_b0, data_out_b0);
    simple_dualport_RAM #(complex_BW) bank1(clk, valid, we_b1, re_b1, waddr_b1, raddr_b1, data_in_b1, data_out_b1);

    swap #(complex_BW) swap0(swap_en, data_out_b0, data_out_b1, swap0_up, swap0_lo);

    BF #(BW) butterfly(swap0_up[complex_BW-1:BW], swap0_up[BW-1:0], swap0_lo[complex_BW-1:BW], swap0_lo[BW-1:0], bf_up[complex_BW+1:BW+1], bf_up[BW:0], bf_lo[complex_BW+1:BW+1], bf_lo[BW:0]);
    MULT #(complex_BW+2) mult(clk, cnt, bf_lo, mult_out);
    
    swap #(complex_BW+2) swap1(swap_en, bf_up, mult_out, swap1_up, swap1_lo);
    
    controlblock ctr(cnt,clk, valid, waddr_b0, raddr_b0, waddr_b1, raddr_b1, we_b0, re_b0, we_b1, re_b1, bank_select, input_done, output_start_temp);
//  reordering vertex_coloring(cnt, bank_select);

// input mux
    assign data_in_b0 =  input_done? mux0_in1 : mux0_in0;
    assign data_in_b1 =  input_done? mux1_in1 : mux1_in0;

// input demux
	always @(bank_select, inReal, inImag) begin
            if(bank_select) begin
                mux1_in0 <= {inReal,inImag};
				mux0_in0 <= 0;
				end
            else begin
				mux1_in0 <= 0;
                mux0_in0 <= {inReal,inImag};
				end

    end
// output demux
    assign mux0_in1 = {swap1_up[complex_BW+1], swap1_up[complex_BW-1 : BW+1],swap1_up[BW],swap1_up[BW-2:0]};
    assign out_up   = {swap1_up[complex_BW+1], swap1_up[complex_BW-1 : BW+1],swap1_up[BW],swap1_up[BW-2:0]};

    assign mux1_in1 = {swap1_lo[complex_BW+1], swap1_lo[complex_BW-1 : BW+1],swap1_lo[BW],swap1_lo[BW-2:0]};
    assign out_lo   = {swap1_lo[complex_BW+1], swap1_lo[complex_BW-1 : BW+1],swap1_lo[BW],swap1_lo[BW-2:0]};

    assign output_start = output_start_temp;
    
    assign cnt_temp = cnt - 224;
    assign bank_select_stage5 = (cnt_temp[5]^cnt_temp[4])^((cnt_temp[3]^cnt_temp[2])^(cnt_temp[1]^cnt_temp[0]));
//output reg
    always @(posedge clk) begin
        if(!nrst | !output_start_temp ) begin
            {outReal0, outImag0} <= 0;
            {outReal1, outImag1} <= 0;
        end
        else  begin
            {outReal0, outImag0} <= out_up;
            {outReal1, outImag1} <= out_lo;
        end
    end
    /*
    always @(posedge clk) begin
        if(!nrst)
            swap_en = 0;
        else
            swap_en = bank_select;
    end
    */

    always @(negedge cnt[4]) begin
        if(nrst & input_done) begin
            stage = stage + 1;
        end
        else if(!nrst)
            stage = 3'b111;
        else
            stage = stage;
    end

    always @(posedge clk) begin
        case(stage)
            3'd0 :
                swap_en = cnt[4];
            3'd1 :
                swap_en = cnt[3];
            3'd2 :
                swap_en = cnt[2];
            3'd3 :
                swap_en = cnt[1];
            3'd4 :
                swap_en = cnt[0];
            3'd5 :
                swap_en = bank_select;
            default
                swap_en = 0;
        endcase
    end
//pipeline reg
/*
    always @(posedge clk) begin
        if(valid) begin
            mux0_in1 <= temp_up;
            mux1_in1 <= temp_lo;
        end
        if(!nrst) begin
            mux0_in1 <= 0;
            mux1_in1 <= 0;
        end
    end
*/
endmodule
