module controlblock (
    input[7:0] cnt,
	input clk, valid,
    output[4:0] waddr_b0, raddr_b0, waddr_b1, raddr_b1,
    output we_b0, re_b0, we_b1, re_b1,
    output bank_select, input_done, output_start
);
    wire[5:0]  raddr_b0_temp, raddr_b1_temp;
    //reg input_done_temp, input_done_delay;
    reg [5:0] increment, waddr_b0_temp, waddr_b1_temp;
    reg [1:0] output_start_reg, bank_select_reg, input_done_reg;
	
    always @(cnt)begin

        //input_done_reg
        if (cnt >= 63) 
            input_done_reg[0] = 1'b1;
        else
            input_done_reg[0] = 1'b0;
        
        if(cnt >=64 && cnt < 96) 
            increment = cnt[4] ? -16 : 16;
        
        else if(cnt >= 96 && cnt <128)
            increment = cnt[3] ? -8 : 8;

        else if(cnt >= 128 && cnt <160)
            increment = cnt[2] ? -4 : 4;

        else if(cnt >= 160 && cnt <192)
            increment = cnt[1] ? -2 : 2;
        
        else if(cnt >= 192 && cnt <224)
            increment = cnt[0] ? -1 : 1;
        else
            increment = 0;
        
        //output_start_reg
        if (cnt >= 224) 
            output_start_reg[0] = 1'b1;
        else
            output_start_reg[0] = 1'b0;

    end

    always @(negedge clk) begin
        if(valid) begin
            waddr_b0_temp <= raddr_b0_temp;
            waddr_b1_temp <= raddr_b1_temp;
            input_done_reg[1] <= input_done_reg[0];
            output_start_reg[1] = output_start_reg[0];
            bank_select_reg[1] = bank_select_reg[0];
        end

    end
    assign input_done = input_done_reg[0];
    assign output_start =  output_start_reg[1];
    assign bank_select = bank_select_reg[1];

    assign bank_select_reg[0] = (cnt[5]^cnt[4])^((cnt[3]^cnt[2])^(cnt[1]^cnt[0]));

    assign we_b0 = (~input_done_reg[1] & ~bank_select_reg[1]) | (input_done_reg[1] & ~ output_start_reg[1]);
    assign we_b1 = (~input_done_reg[1] & bank_select_reg[1])  | (input_done_reg[1] & ~ output_start_reg[1]);

    assign re_b0 = input_done_reg[0];
    assign re_b1 = input_done_reg[0];


    assign raddr_b0_temp = cnt[4:0];
    assign raddr_b1_temp = raddr_b0_temp + increment;
    assign raddr_b0 = input_done_reg[0];
    assign raddr_b1 = input_done_reg[0];

    assign waddr_b0 = input_done_reg[0] ? waddr_b0_temp : (cnt-1)>>1;
    assign waddr_b1 = input_done_reg[0] ? waddr_b1_temp : (cnt-1)>>1 ;

    



endmodule
