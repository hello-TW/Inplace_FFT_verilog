module counter
(
    input   nrst, clk, start, valid,
    output  reg [7:0]  cnt
);

always @(negedge clk) begin
    if(!nrst)
        cnt <= 8'b11111111;   // == 63 in decade
    else if (start && valid)
        cnt <= cnt + 1;
    else
        cnt <= cnt;
end

endmodule

// refer to 64-pt R2SDF FFT code