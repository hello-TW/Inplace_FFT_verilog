module simple_dualport_RAM
#(
    parameter BW = 16
)(
    input clk, valid, we, re,              // we: write enable, re: read enable
    input [4:0] addr_w, addr_r,            // address for read/write
    input [BW-1:0] data_in,
    output reg [BW-1:0] data_out
);
reg [BW-1:0] ram [0:31];

always @(posedge clk) begin
    if (valid && we) begin
        ram[addr_w] <= data_in;     
    end
end

always @(posedge clk) begin
    if (valid && re)
        data_out <= ram[addr_r];
end

endmodule