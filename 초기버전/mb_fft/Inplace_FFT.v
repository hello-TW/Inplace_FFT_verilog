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
    wire we_b0, re_b0, input_done, output_start_temp, bank_select;
	wire [7:0] cnt;
    wire [4:0] waddr_b0, waddr_b1, raddr_b0, raddr_b1;
    wire [complex_BW-1:0] data_in_b0, data_in_b1, data_out_b0, data_out_b1; 
    wire [complex_BW-1:0] swap0_up, swap0_lo, swap1_up, swap1_lo, mult_out;
    wire [complex_BW-1:0] bf_up, bf_lo;
    wire [complex_BW-1:0] mux0_in1, mux1_in1, out_up, out_lo;
    reg  [complex_BW-1:0] mux0_in0, mux1_in0, in_reg, temp_up, temp_lo;

    counter counter_inst(nrst, clk, start, valid, cnt);

    simple_dualport_RAM #(complex_BW) bank0(clk, valid, we_b0, re_b0, waddr_b0, raddr_b0, data_in_b0, data_out_b0);
    simple_dualport_RAM #(complex_BW) bank1(clk, valid, we_b1, re_b1, waddr_b1, raddr_b1, data_in_b1, data_out_b1);

    swap #(complex_BW) swap0(bank_select, data_out_b0, data_out_b1, swap0_up, swap0_lo);

    BF #(BW) butterfly(swap0_up[complex_BW-1:BW], swap0_up[BW-1:0], swap0_lo[complex_BW-1:BW], swap0_lo[BW-1:0], bf_up[complex_BW-1:BW], bf_up[BW-1:0], bf_lo[complex_BW-1:BW], bf_lo[BW-1:0]);
    MULT #(complex_BW) mult(cnt, bf_lo, mult_out);
    
    swap #(complex_BW) swap1(bank_select, bf_up, mult_out, swap1_up, swap1_lo);
    
    controlblock ctr(cnt,clk, valid, waddr_b0, raddr_b0, waddr_b1, raddr_b1, we_b0, re_b0, we_b1, re_b1, bank_select, input_done, output_start_temp);
//  reordering vertex_coloring(cnt, bank_select);

// input mux
    assign data_in_b0 =  input_done? mux0_in1 : mux0_in0;
    assign data_in_b1 =  input_done? mux1_in1 : mux1_in0;

// input demux
	always @(bank_select, in_reg) begin
            if(bank_select) begin
                mux1_in0 <= in_reg;
				mux0_in0 <= 0;
				end
            else begin
				mux1_in0 <= 0;
                mux0_in0 <= in_reg;
				end

    end
	 /*
    assign mux0_in1 = ~bank_select & in_reg;
    assign mux1_in1 = bank_select & in_reg;
    */
// output demux
    assign mux0_in1 = swap1_up;
    assign out_up = swap1_up;

    assign mux1_in1 = swap1_lo;
    assign out_lo = swap1_lo;

    /*    
    always @(output_start_temp, swap1_up, swap1_lo) begin
            if(output_start_temp) begin
                mux0_in1 <= 0;
			    mux1_in1 <= 0;
				out_up <= swap1_up;
                out_lo <= swap1_lo;
            end
            else begin
                mux0_in1 <= swap1_up;
                mux1_in1 <= swap1_lo;
				out_up <= 0;
				out_lo <= 0;
            end

    end
    */
	 
    /*
    assign temp_up = ~output_start_temp & swap1_up;
    assign out_up = output_start_temp & swap1_up;
    assign temp_lo = ~output_start_temp & swap1_lo;
    assign out_lo = output_start_temp & swap1_lo; 
    */

    assign output_start = output_start_temp;

//input reg
    always @(posedge clk) begin
        if(valid) 
            in_reg <= {inReal,inImag};
        if(!nrst) 
            in_reg <= 0;
    end

//output reg
    always @(posedge clk) begin
        if(output_start_temp) begin
            {outReal0, outImag0} <= out_up;
            {outReal1, outImag1} <= out_lo;
        end
        if(!nrst | !output_start_temp ) begin
            {outReal0, outImag0} <= 0;
            {outReal1, outImag1} <= 0;
        end
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
