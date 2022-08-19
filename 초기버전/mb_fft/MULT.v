module MULT #(
    parameter BW = 32
)(
    input[7:0] cnt,
    input signed[BW-1:0] data_in,//(9:4)
    output signed[BW-1:0] data_out//(9:4)
);
    parameter H= BW/2;
    wire [H-1:0] data_in_re;
    wire [H-1:0] data_in_im;
    wire [H-1:0] data_out_re;
    wire [H-1:0] data_out_im;
    
    assign data_in_re = data_in[BW-1:H];
    assign data_in_im = data_in[H-1:0];

    parameter signed W_re0=12'b010000000000;
    parameter signed W_re1=12'b001111111011;
    parameter signed W_re2=12'b001111101100;
    parameter signed W_re3=12'b001111010011;
    parameter signed W_re4=12'b001110110010;
    parameter signed W_re5=12'b001110000111;
    parameter signed W_re6=12'b001101010011;
    parameter signed W_re7=12'b001100010111;
    parameter signed W_re8=12'b001011010100;
    parameter signed W_re9=12'b001010001001;
    parameter signed W_re10=12'b001000111000;
    parameter signed W_re11=12'b000111100010;
    parameter signed W_re12=12'b000110000111;
    parameter signed W_re13=12'b000100101001;
    parameter signed W_re14=12'b000011000111;
    parameter signed W_re15=12'b000001100100;
    parameter signed W_re16=12'b000000000000;
    parameter signed W_re17=12'b111110011011;
    parameter signed W_re18=12'b111100111000;
    parameter signed W_re19=12'b111011010110;
    parameter signed W_re20=12'b111001111000;
    parameter signed W_re21=12'b111000011101;
    parameter signed W_re22=12'b110111000111;
    parameter signed W_re23=12'b110101110110;
    parameter signed W_re24=12'b110100101011;
    parameter signed W_re25=12'b110011101000;
    parameter signed W_re26=12'b110010101100;
    parameter signed W_re27=12'b110001111000;
    parameter signed W_re28=12'b110001001101;
    parameter signed W_re29=12'b110000101100;
    parameter signed W_re30=12'b110000010011;
    parameter signed W_re31=12'b110000000100;
    
    parameter signed W_im0=12'b000000000000;
    parameter signed W_im1=12'b111110011011;
    parameter signed W_im2=12'b111100111000;
    parameter signed W_im3=12'b111011010110;
    parameter signed W_im4=12'b111001111000;
    parameter signed W_im5=12'b111000011101;
    parameter signed W_im6=12'b110111000111;
    parameter signed W_im7=12'b110101110110;
    parameter signed W_im8=12'b110100101011;
    parameter signed W_im9=12'b110011101000;
    parameter signed W_im10=12'b110010101100;
    parameter signed W_im11=12'b110001111000;
    parameter signed W_im12=12'b110001001101;
    parameter signed W_im13=12'b110000101100;
    parameter signed W_im14=12'b110000010011;
    parameter signed W_im15=12'b110000000100;
    parameter signed W_im16=12'b110000000000;
    parameter signed W_im17=12'b110000000100;
    parameter signed W_im18=12'b110000010011;
    parameter signed W_im19=12'b110000101100;
    parameter signed W_im20=12'b110001001101;
    parameter signed W_im21=12'b110001111000;
    parameter signed W_im22=12'b110010101100;
    parameter signed W_im23=12'b110011101000;
    parameter signed W_im24=12'b110100101011;
    parameter signed W_im25=12'b110101110110;
    parameter signed W_im26=12'b110111000111;
    parameter signed W_im27=12'b111000011101;
    parameter signed W_im28=12'b111001111000;
    parameter signed W_im29=12'b111011010110;
    parameter signed W_im30=12'b111100111000;
    parameter signed W_im31=12'b111110011011;
    reg signed [11:0] temp_re; //[10:0]
    reg signed [11:0] temp_im; //[10:0]
    wire signed [BW+12:0] buf_re; //[23:0]
    wire signed [BW+12:0] buf_im; //[23:0]
    always @(*) begin
        case (cnt)
            8'd64 : begin                //stage1 start
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd65 : begin
                    temp_re <= W_re3;
                    temp_im <= W_im3;
                    end   
            8'd66 : begin
                    temp_re <= W_re5;
                    temp_im <= W_im5;
                    end
            8'd67 : begin
                    temp_re <= W_re6;
                    temp_im <= W_im6;
                    end
            8'd68 : begin
                    temp_re <= W_re9;
                    temp_im <= W_im9;
                    end   
            8'd69 : begin
                    temp_re <= W_re10;
                    temp_im <= W_im10;
                    end   
            8'd70 : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end
            8'd71 : begin
                    temp_re <= W_re15;
                    temp_im <= W_im15;
                    end
            8'd72 : begin
                    temp_re <= W_re17;
                    temp_im <= W_im17;
                    end   
            8'd73 : begin
                    temp_re <= W_re18;
                    temp_im <= W_im18;
                    end   
            8'd74 : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
            8'd75 : begin
                    temp_re <= W_re23;
                    temp_im <= W_im23;
                    end
            8'd76 : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
            8'd77 : begin
                    temp_re <= W_re27;
                    temp_im <= W_im27;
                    end   
            8'd78 : begin
                    temp_re <= W_re29;
                    temp_im <= W_im29;
                    end
            8'd79 : begin
                    temp_re <= W_re30;
                    temp_im <= W_im30;
                    end
            8'd80 : begin
                    temp_re <= W_re1;
                    temp_im <= W_im1;
                    end   
            8'd81 : begin
                    temp_re <= W_re2;
                    temp_im <= W_im2;
                    end   
            8'd82 : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end
            8'd83 : begin
                    temp_re <= W_re7;
                    temp_im <= W_im7;
                    end
            8'd84 : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd85 : begin
                    temp_re <= W_re11;
                    temp_im <= W_im11;
                    end   
            8'd86 : begin
                    temp_re <= W_re13;
                    temp_im <= W_im13;
                    end
            8'd87 : begin
                    temp_re <= W_re14;
                    temp_im <= W_im14;
                    end
            8'd88 : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd89 : begin
                    temp_re <= W_re19;
                    temp_im <= W_im19;
                    end   
            8'd90 : begin
                    temp_re <= W_re21;
                    temp_im <= W_im21;
                    end
            8'd91 : begin
                    temp_re <= W_re22;
                    temp_im <= W_im22;
                    end
            8'd92 : begin
                    temp_re <= W_re25;
                    temp_im <= W_im25;
                    end   
            8'd93 : begin
                    temp_re <= W_re26;
                    temp_im <= W_im26;
                    end   
            8'd94 : begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
            8'd95 : begin
                    temp_re <= W_re31;
                    temp_im <= W_im31;
                    end
            8'd96 : begin                //stage2 start
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd97 : begin
                    temp_re <= W_re6;
                    temp_im <= W_im6;
                    end   
            8'd98 : begin
                    temp_re <= W_re10;
                    temp_im <= W_im10;
                    end
            8'd99 : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end
            8'd100 : begin
                    temp_re <= W_re18;
                    temp_im <= W_im18;
                    end   
            8'd101: begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end   
            8'd102: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd103: begin
                    temp_re <= W_re30;
                    temp_im <= W_im30;
                    end
            8'd104: begin
                    temp_re <= W_re2;
                    temp_im <= W_im2;
                    end   
            8'd105: begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
            8'd106: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
            8'd107: begin
                    temp_re <= W_re14;
                    temp_im <= W_im14;
                    end
            8'd108: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd109: begin
                    temp_re <= W_re22;
                    temp_im <= W_im22;
                    end   
            8'd110: begin
                    temp_re <= W_re26;
                    temp_im <= W_im26;
                    end
            8'd111: begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
            8'd112: begin
                    temp_re <= W_re2;
                    temp_im <= W_im2;
                    end   
            8'd113: begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
            8'd114: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
            8'd115: begin
                    temp_re <= W_re14;
                    temp_im <= W_im14;
                    end
            8'd116: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd117: begin
                    temp_re <= W_re22;
                    temp_im <= W_im22;
                    end   
            8'd118: begin
                    temp_re <= W_re26;
                    temp_im <= W_im26;
                    end
            8'd119: begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
            8'd120: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd121: begin
                    temp_re <= W_re6;
                    temp_im <= W_im6;
                    end   
            8'd122: begin
                    temp_re <= W_re10;
                    temp_im <= W_im10;
                    end
            8'd123: begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end
            8'd124: begin
                    temp_re <= W_re18;
                    temp_im <= W_im18;
                    end   
            8'd125: begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end   
            8'd126: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd127: begin
                    temp_re <= W_re30;
                    temp_im <= W_im30;
                    end
            8'd128 : begin                //stage3 start
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd129 : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end   
            8'd130 : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
            8'd131 : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd132 : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
            8'd133: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd134: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd135: begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
            8'd136: begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
            8'd137: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd138: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd139: begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
            8'd140: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd141: begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end   
            8'd142: begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
            8'd143: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd144: begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
            8'd145: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd146: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd147: begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
            8'd148: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd149: begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end   
            8'd150: begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
            8'd151: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd152: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd153: begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end   
            8'd154: begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
            8'd155: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd156: begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
            8'd157: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd158: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd159: begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end 
            8'd160 : begin                //stage4 start
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd161 : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
            8'd162 : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
            8'd163 : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd164 : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd165: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd166: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd167: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd168: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd169: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd170: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd171: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd172: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd173: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
            8'd174: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
            8'd175: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd176: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd177: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd178: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd179: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
            8'd180: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd181: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
            8'd182: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
            8'd183: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd184: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd185: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
            8'd186: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
            8'd187: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd188: begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
            8'd189: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd190: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd191: begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end 
            8'd192 : begin                //stage5 start
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd193 : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd194 : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd195 : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd196 : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd197: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd198: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd199: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd200: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd201: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd202: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd203: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd204: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd205: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd206: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd207: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd208: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd209: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd210: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd211: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd212: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd213: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd214: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd215: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd216: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd217: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd218: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
            8'd219: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd220: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
            8'd221: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
            8'd222: begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
            8'd223: begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end                                          
            default: begin                //stage6's twiddle factors are always 1 
                    temp_re <= W_re0;
                    temp_im <= W_im0;
            end
        endcase
    end
    
    assign buf_re = (temp_re*data_in_re)-(temp_im*data_in_im); // [24:0]
    assign buf_im = (temp_im*data_in_re)+(temp_re*data_in_im); // [24:0]
    
    assign data_out_re = {buf_re[BW+12],buf_re[BW+8:10]};
    assign data_out_im = {buf_im[BW+12],buf_im[BW+8:10]};
    assign data_out = {data_out_re,data_out_im};

endmodule
