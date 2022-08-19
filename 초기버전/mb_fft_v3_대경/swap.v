module swap #(
    parameter BW=32
)
(
    input swap_en,
    input [BW-1:0] in_data1,
	input [BW-1:0] in_data2,
    output [BW-1:0] out_data1,
	output [BW-1:0] out_data2
);
reg [BW-1:0] temp1, temp2;
always @(swap_en, in_data1, in_data2) begin
    if(swap_en) begin
        temp2 <= in_data1;
        temp1 <= in_data2;
    end else begin
        temp1 <= in_data1;
        temp2 <= in_data2;
    end
end

assign out_data1 = temp1;
assign out_data2 = temp2;
endmodule
