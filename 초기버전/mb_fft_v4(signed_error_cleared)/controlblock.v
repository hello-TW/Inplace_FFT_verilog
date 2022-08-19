module controlblock (
	input clk, valid, nrst,
    input [7:0] cnt,
    output input_done, swap0_en, swap1_en,
    output we_b0, re_b0, we_b1, re_b1,
    output [4:0] waddr_b0, raddr_b0, waddr_b1, raddr_b1
);
    wire bank_select_temp, bank_select_stage6;
	wire [7:0] cnt_stage6;
    reg input_done_temp, swap0_en_temp, swap1_en_temp;
    reg we_b0_temp, re_b0_temp, we_b1_temp, re_b1_temp;
    reg [2:0] state;
//  reg signed [5:0] waddr_b0_temp, waddr_b1_temp, raddr_b0_temp, raddr_b1_temp;
    reg [5:0] waddr_b0_temp, waddr_b1_temp, raddr_b0_temp, raddr_b1_temp;
//  reg signed [5:0] raddr_b0_reg, raddr_b1_reg;
    reg [5:0] raddr_b0_reg, raddr_b1_reg;
    reg signed [5:0] increment;
    //FSM
    parameter input_state  = 3'd0;
    parameter stage1_1_state = 3'd1;
    parameter stage1_state = 3'd2;
    parameter stage2_state = 3'd3;
    parameter stage3_state = 3'd4;
    parameter stage4_state = 3'd5;
    parameter stage5_state = 3'd6;
    parameter stage6_state = 3'd7;

    //state
    always @(posedge clk) begin
        if(nrst == 0)
            state = input_state;
        else begin
            if (cnt == 63) 
                state = stage1_1_state;
            else if (cnt == 64)
                state = stage1_state;
            else if (cnt == 95)
                state = stage2_state;
            else if (cnt == 127)
                state = stage3_state;
            else if (cnt == 159)
                state = stage4_state;
            else if (cnt == 191)
                state = stage5_state;
            else if (cnt == 223)
                state = stage6_state;
            else if (cnt == 255)
                state = input_state;
            else
                state = state;
        end
    end

    //output
    always @(state, cnt, raddr_b0_reg, raddr_b1_reg) begin
        case(state)
            input_state : begin
                input_done_temp = 0;
                swap0_en_temp = 0;
                swap1_en_temp = 0;
                increment = 0;
                we_b0_temp = ~bank_select_temp;
                we_b1_temp = bank_select_temp;
                re_b0_temp = 0;
                re_b1_temp = 0;
                waddr_b0_temp = cnt>>1;
                waddr_b1_temp = cnt>>1;
                raddr_b0_temp = 0;
                raddr_b1_temp = 0;
            end
            stage1_1_state : begin
                input_done_temp = 0;
                swap0_en_temp = 0;
                swap1_en_temp = 0;
                increment = 16;
                we_b0_temp = 0;
                we_b1_temp = 0;
                re_b0_temp = 1;
                re_b1_temp = 1;
                waddr_b0_temp = 0;
                waddr_b1_temp = 0;
                raddr_b0_temp = cnt;
                raddr_b1_temp = $unsigned($signed(cnt) + increment);
            end
            stage1_state : begin
                input_done_temp = 1;
                swap0_en_temp = cnt[4];
                swap1_en_temp = cnt[4];
                increment = cnt[4] ? -16 : 16;
                we_b0_temp = 1;
                we_b1_temp = 1;
                re_b0_temp = 1;
                re_b1_temp = 1;
                waddr_b0_temp = raddr_b0_reg;
                waddr_b1_temp = raddr_b1_reg;
                raddr_b0_temp = cnt;
                raddr_b1_temp = $unsigned($signed(cnt) + increment);
            end
            stage2_state : begin
                input_done_temp = 1;
                swap0_en_temp = cnt[3];
                swap1_en_temp = cnt[3];
                increment = cnt[3] ? -8 : 8;
                we_b0_temp = 1;
                we_b1_temp = 1;
                re_b0_temp = 1;
                re_b1_temp = 1;
                waddr_b0_temp = raddr_b0_reg;
                waddr_b1_temp = raddr_b1_reg;
                raddr_b0_temp = cnt;
                raddr_b1_temp = $unsigned($signed(cnt) + increment);
            end
            stage3_state : begin
                input_done_temp = 1;
                swap0_en_temp = cnt[2];
                swap1_en_temp = cnt[2];
                increment = cnt[2] ? -4 : 4;
                we_b0_temp = 1;
                we_b1_temp = 1;
                re_b0_temp = 1;
                re_b1_temp = 1;
                waddr_b0_temp = raddr_b0_reg;
                waddr_b1_temp = raddr_b1_reg;
                raddr_b0_temp = cnt;
                raddr_b1_temp = $unsigned($signed(cnt) + increment);
            end
            stage4_state : begin
                input_done_temp = 1;
                swap0_en_temp = cnt[1];
                swap1_en_temp = cnt[1];
                increment = cnt[1] ? -2 : 2;
                we_b0_temp = 1;
                we_b1_temp = 1;
                re_b0_temp = 1;
                re_b1_temp = 1;
                waddr_b0_temp = raddr_b0_reg;
                waddr_b1_temp = raddr_b1_reg;
                raddr_b0_temp = cnt;
                raddr_b1_temp = $unsigned($signed(cnt) + increment);
            end
            stage5_state : begin
                input_done_temp = 1;
                swap0_en_temp = cnt[0];
                swap1_en_temp = cnt[0];
                increment = cnt[0] ? -1 : 1;
                we_b0_temp = 1;
                we_b1_temp = 1;
                re_b0_temp = 1;
                re_b1_temp = 1;
                waddr_b0_temp = raddr_b0_reg;
                waddr_b1_temp = raddr_b1_reg;
                raddr_b0_temp = cnt;
                raddr_b1_temp = $unsigned($signed(cnt) + increment);
            end
            default : begin //stage6_stage
                input_done_temp = 1;
                swap0_en_temp = bank_select_stage6;
                swap1_en_temp = 0;
                increment = 0;
                we_b0_temp = 1;
                we_b1_temp = 1;
                re_b0_temp = 1;
                re_b1_temp = 1;
                waddr_b0_temp = raddr_b0_reg;
                waddr_b1_temp = raddr_b1_reg;
                raddr_b0_temp = cnt;
                raddr_b1_temp = $unsigned($signed(cnt) + increment);
            end
        endcase
    end
    
    always @(posedge clk) begin
        if(valid) begin
            raddr_b0_reg <= raddr_b0_temp;
            raddr_b1_reg <= raddr_b1_temp;
        end
    end

    //assign output xor
    assign cnt_stage6 = cnt - 224;
    assign bank_select_stage6 = (cnt_stage6[5]^cnt_stage6[4])^((cnt_stage6[3]^cnt_stage6[2])^(cnt_stage6[1]^cnt_stage6[0]));
    assign bank_select_temp = (cnt[5]^cnt[4])^((cnt[3]^cnt[2])^(cnt[1]^cnt[0]));


    //assign port
    assign input_done = input_done_temp;
    assign swap0_en = swap0_en_temp;
    assign swap1_en = swap1_en_temp;
    assign we_b0 = we_b0_temp;
    assign re_b0 = re_b0_temp; 
    assign we_b1 = we_b1_temp; 
    assign re_b1 = re_b1_temp;
    assign waddr_b0 = waddr_b0_temp;
    assign waddr_b1 = waddr_b1_temp;
    assign raddr_b0 = raddr_b0_temp;
    assign raddr_b1 = raddr_b1_temp;
endmodule
