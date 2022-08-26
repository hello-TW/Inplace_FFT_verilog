module controlblock (
	input clk, valid, nrst, start,
    output input_done, output_start, bank_select, swap0_en, swap1_en,
    output we_b0, re_b0, we_b1, re_b1,
    output [4:0] waddr_b0, raddr_b0, waddr_b1, raddr_b1,
    output [7:0] cnt
);

    //temporary variables
    wire bank_select_temp, bank_select_stage6;
	wire [7:0] cnt_temp;
    reg input_done_temp, output_start_temp, swap0_en_temp, swap1_en_temp;
    reg we_b0_temp, re_b0_temp, we_b1_temp, re_b1_temp;
	reg [4:0] waddr_b0_temp, waddr_b1_temp, raddr_b0_temp, raddr_b1_temp;
    
    //register
    reg output_start_reg[1:0], swap0_en_reg, swap1_en_reg[1:0];
    reg re_b0_reg[1:0], re_b1_reg[1:0];
    reg [2:0] state;
    reg [4:0] raddr_b0_reg[1:0], raddr_b1_reg[1:0];
    reg signed [4:0] increment;

    //FSM states
    parameter input_state  = 3'd0;
    parameter stage1_1_state = 3'd1;
    parameter stage1_state = 3'd2;
    parameter stage2_state = 3'd3;
    parameter stage3_state = 3'd4;
    parameter stage4_state = 3'd5;
    parameter stage5_state = 3'd6;
    parameter stage6_state = 3'd7;

    //counter instantiation
    counter counter(nrst, clk, start, valid, cnt_temp);

//state change
always @(posedge clk) begin
    if(nrst == 0)
        state = input_state;
    else begin
        if (cnt_temp == 63) 
            state = stage1_1_state;
        else if (cnt_temp == 65)
            state = stage1_state;
        else if (cnt_temp == 95)
            state = stage2_state;
        else if (cnt_temp == 127)
            state = stage3_state;
        else if (cnt_temp == 159)
            state = stage4_state;
        else if (cnt_temp == 191)
            state = stage5_state;
        else if (cnt_temp == 223)
            state = stage6_state;
        else if (cnt_temp == 255)
            state = input_state;
        else
            state = state;
    end
end

    //output
    always @(state, cnt_temp, raddr_b0_reg, raddr_b1_reg, bank_select_temp, bank_select_stage6) begin
        case(state)
            input_state : begin
                input_done_temp = 1'b0;
                output_start_temp = 1'b0;
                swap0_en_temp = 1'b0;
                swap1_en_temp = 1'b0;
                increment = 5'd0;
                we_b0_temp = ~bank_select_temp;
                we_b1_temp = bank_select_temp;
                re_b0_temp = 1'b0;
                re_b1_temp = 1'b0;
                waddr_b0_temp = cnt_temp>>1;
                waddr_b1_temp = cnt_temp>>1;
                raddr_b0_temp = 0;
                raddr_b1_temp = 0;
            end
            stage1_1_state : begin
                input_done_temp = 1'b1;
                output_start_temp = 1'b0;
                swap0_en_temp = cnt_temp[4];
                swap1_en_temp = cnt_temp[4];
                increment = cnt_temp[4] ? -16 : 16;
                we_b0_temp = 1'b0;
                we_b1_temp = 1'b0;
                re_b0_temp = 1'b1;
                re_b1_temp = 1'b1;
                waddr_b0_temp = raddr_b0_reg[1];
                waddr_b1_temp = raddr_b1_reg[1];
                raddr_b0_temp = cnt_temp[5:0];
                raddr_b1_temp = $unsigned($signed(cnt_temp[5:0]) + increment);
            end
            stage1_state : begin
                input_done_temp = 1'b1;
                output_start_temp = 1'b0;
                swap0_en_temp = cnt_temp[4];
                swap1_en_temp = cnt_temp[4];
                increment = cnt_temp[4] ? -16 : 16;
                we_b0_temp = 1'b1;
                we_b1_temp = 1'b1;
                re_b0_temp = 1'b1;
                re_b1_temp = 1'b1;
                waddr_b0_temp = raddr_b0_reg[1];
                waddr_b1_temp = raddr_b1_reg[1];
                raddr_b0_temp = cnt_temp[5:0];
                raddr_b1_temp = $unsigned($signed(cnt_temp[5:0]) + increment);
            end
            stage2_state : begin
                input_done_temp = 1'b1;
                output_start_temp = 1'b0;
                swap0_en_temp = cnt_temp[3];
                swap1_en_temp = cnt_temp[3];
                increment = cnt_temp[3] ? -8 : 8;
                we_b0_temp = 1'b1;
                we_b1_temp = 1'b1;
                re_b0_temp = 1'b1;
                re_b1_temp = 1'b1;
                waddr_b0_temp = raddr_b0_reg[1];
                waddr_b1_temp = raddr_b1_reg[1];
                raddr_b0_temp = cnt_temp[5:0];
                raddr_b1_temp = $unsigned($signed(cnt_temp[5:0]) + increment);
            end
            stage3_state : begin
                input_done_temp = 1'b1;
                output_start_temp = 1'b0;
                swap0_en_temp = cnt_temp[2];
                swap1_en_temp = cnt_temp[2];
                increment = cnt_temp[2] ? -4 : 4;
                we_b0_temp = 1'b1;
                we_b1_temp = 1'b1;
                re_b0_temp = 1'b1;
                re_b1_temp = 1'b1;
                waddr_b0_temp = raddr_b0_reg[1];
                waddr_b1_temp = raddr_b1_reg[1];
                raddr_b0_temp = cnt_temp[5:0];
                raddr_b1_temp = $unsigned($signed(cnt_temp[5:0]) + increment);
            end
            stage4_state : begin
                input_done_temp = 1'b1;
                output_start_temp = 1'b0;
                swap0_en_temp = cnt_temp[1];
                swap1_en_temp = cnt_temp[1];
                increment = cnt_temp[1] ? -2 : 2;
                we_b0_temp = 1'b1;
                we_b1_temp = 1'b1;
                re_b0_temp = 1'b1;
                re_b1_temp = 1'b1;
                waddr_b0_temp = raddr_b0_reg[1];
                waddr_b1_temp = raddr_b1_reg[1];
                raddr_b0_temp = cnt_temp[5:0];
                raddr_b1_temp = $unsigned($signed(cnt_temp[5:0]) + increment);
            end
            stage5_state : begin
                input_done_temp = 1'b1;
                output_start_temp = 1'b0;
                swap0_en_temp = cnt_temp[0];
                swap1_en_temp = cnt_temp[0];
                increment = cnt_temp[0] ? -1 : 1;
                we_b0_temp = 1'b1;
                we_b1_temp = 1'b1;
                re_b0_temp = 1'b1;
                re_b1_temp = 1'b1;
                waddr_b0_temp = raddr_b0_reg[1];
                waddr_b1_temp = raddr_b1_reg[1];
                raddr_b0_temp = cnt_temp[5:0];
                raddr_b1_temp = $unsigned($signed(cnt_temp[5:0]) + increment);
            end
            default : begin //stage6_stage
                input_done_temp = 1'b1;
                output_start_temp = 1'b1;
                swap0_en_temp = bank_select_stage6;
                swap1_en_temp = 1'b0;
                increment = 0;
                we_b0_temp = 1'b1;
                we_b1_temp = 1'b1;
                re_b0_temp = 1'b1;
                re_b1_temp = 1'b1;
                waddr_b0_temp = raddr_b0_reg[1];
                waddr_b1_temp = raddr_b1_reg[1];
                raddr_b0_temp = cnt_temp[5:0];
                raddr_b1_temp = $unsigned($signed(cnt_temp[5:0]) + increment);
            end
        endcase
    end

    //register
    always @(posedge clk) begin
        if(valid) begin
            raddr_b0_reg[0] <= raddr_b0_temp;
            raddr_b0_reg[1] <= raddr_b0_reg[0];
            raddr_b1_reg[0] <= raddr_b1_temp;
            raddr_b1_reg[1] <= raddr_b1_reg[0];

            swap0_en_reg <= swap0_en_temp;
            swap1_en_reg[0] <= swap1_en_temp;
            swap1_en_reg[1] <= swap1_en_reg[0];

            output_start_reg[0] <= output_start_temp;
            output_start_reg[1] <= output_start_reg[0];
        end
    end

    assign bank_select_stage6 = (cnt_temp[4])^((cnt_temp[3]^cnt_temp[2])^(cnt_temp[1]^cnt_temp[0]));
    assign bank_select_temp = (cnt_temp[5]^cnt_temp[4])^((cnt_temp[3]^cnt_temp[2])^(cnt_temp[1]^cnt_temp[0]));

//assign port
assign input_done = input_done_temp;
assign output_start = output_start_reg[1];
assign bank_select = bank_select_temp;
assign swap0_en = swap0_en_reg;
assign swap1_en = swap1_en_reg[1];
assign we_b0 = we_b0_temp;
assign re_b0 = re_b0_temp; 
assign we_b1 = we_b1_temp; 
assign re_b1 = re_b1_temp;
assign waddr_b0 = waddr_b0_temp;
assign waddr_b1 = waddr_b1_temp;
assign raddr_b0 = raddr_b0_temp;
assign raddr_b1 = raddr_b1_temp;
assign cnt = cnt_temp;

    
endmodule
