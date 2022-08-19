module pipeline_reg #(
    parameter BW = 1
)(
    input clk, nrst, valid,
    input [BW-1:0] d,
    output [BW-1:0] q
);

    reg [BW-1:0] q_temp;

    always @(posedge clk) begin
        if(!nrst)
            q_temp = 0;
        else if(valid)
            q_temp = d;
        else
            q_temp = q_temp;
    end

    assign q = q_temp;
endmodule
