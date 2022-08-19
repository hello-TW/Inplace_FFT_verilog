module bit_slice_sat #(
    parameter BW = 16 // output bit width
)(
    input signed[BW:0] data_in,
    output signed[BW-1:0] data_out
);
    parameter signed [BW-1:0] MAX = 2**(BW-1)-1;
    parameter signed [BW-1:0] MIN = (-1)*2**(BW-1);
    reg signed [BW-1:0] data_out_reg;

    always @(data_in) begin
        if(data_in > MAX)
            data_out_reg = MAX;
        else if(data_in < MIN)
            data_out_reg = MIN;
        else
            data_out_reg = {data_in[BW], data_in[BW-2:0]};
    end
    assign data_out = data_out_reg;
endmodule
