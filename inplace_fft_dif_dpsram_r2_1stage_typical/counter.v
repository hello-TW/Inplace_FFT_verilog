module counter
(
    input   nrst, clk, start, valid,
    output  reg [7:0]  cnt
);

always @(posedge clk) begin
    if(!nrst)
        cnt <= 8'b11111111;   // == 63 in decade
    else if (start && valid) begin
        if(cnt == 224)
            cnt <= 8'd0;
        else
	        cnt <= cnt + 1;
    end
    else
        cnt <= cnt;
end

endmodule

// refer to 64-pt R2SDF FFT code