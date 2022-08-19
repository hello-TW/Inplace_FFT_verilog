module MULT_GEN #(
    parameter BW = 32
)
(
    input clk,
    input[7:0] cnt,
    input signed[BW-1:0] data_in,//(9:4)
    output signed[BW-1:0] data_out//(9:4)
);
    parameter H= BW/2;
    wire signed [H-1:0] data_in_re;
    wire signed [H-1:0] data_in_im;
    wire signed [H-1:0] data_out_re;
    wire signed [H-1:0] data_out_im;

    assign data_in_re = $signed(data_in[BW-1:H]);
    assign data_in_im = $signed(data_in[H-1:0]);

    parameter START_CNT = 64;
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
    always @(posedge clk) begin
        case (cnt)
			(START_CNT+0) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+1) : begin
                    temp_re <= W_re3;
                    temp_im <= W_im3;
                    end   
			(START_CNT+2) : begin
                    temp_re <= W_re5;
                    temp_im <= W_im5;
                    end
			(START_CNT+3) : begin
                    temp_re <= W_re6;
                    temp_im <= W_im6;
                    end
			(START_CNT+4) : begin
                    temp_re <= W_re9;
                    temp_im <= W_im9;
                    end   
			(START_CNT+5) : begin
                    temp_re <= W_re10;
                    temp_im <= W_im10;
                    end   
			(START_CNT+6) : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end
			(START_CNT+7) : begin
                    temp_re <= W_re15;
                    temp_im <= W_im15;
                    end
			(START_CNT+8) : begin
                    temp_re <= W_re17;
                    temp_im <= W_im17;
                    end   
			(START_CNT+9) : begin
                    temp_re <= W_re18;
                    temp_im <= W_im18;
                    end   
			(START_CNT+10) : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
			(START_CNT+11) : begin
                    temp_re <= W_re23;
                    temp_im <= W_im23;
                    end
			(START_CNT+12) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
			(START_CNT+13) : begin
                    temp_re <= W_re27;
                    temp_im <= W_im27;
                    end   
			(START_CNT+14) : begin
                    temp_re <= W_re29;
                    temp_im <= W_im29;
                    end
			(START_CNT+15) : begin
                    temp_re <= W_re30;
                    temp_im <= W_im30;
                    end
			(START_CNT+16) : begin
                    temp_re <= W_re1;
                    temp_im <= W_im1;
                    end   
			(START_CNT+17) : begin
                    temp_re <= W_re2;
                    temp_im <= W_im2;
                    end   
			(START_CNT+18) : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end
			(START_CNT+19) : begin
                    temp_re <= W_re7;
                    temp_im <= W_im7;
                    end
			(START_CNT+20) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+21) : begin
                    temp_re <= W_re11;
                    temp_im <= W_im11;
                    end   
			(START_CNT+22) : begin
                    temp_re <= W_re13;
                    temp_im <= W_im13;
                    end
			(START_CNT+23) : begin
                    temp_re <= W_re14;
                    temp_im <= W_im14;
                    end
			(START_CNT+24) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+25) : begin
                    temp_re <= W_re19;
                    temp_im <= W_im19;
                    end   
			(START_CNT+26) : begin
                    temp_re <= W_re21;
                    temp_im <= W_im21;
                    end
			(START_CNT+27) : begin
                    temp_re <= W_re22;
                    temp_im <= W_im22;
                    end
			(START_CNT+28) : begin
                    temp_re <= W_re25;
                    temp_im <= W_im25;
                    end   
			(START_CNT+29) : begin
                    temp_re <= W_re26;
                    temp_im <= W_im26;
                    end   
			(START_CNT+30) : begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
			(START_CNT+31) : begin
                    temp_re <= W_re31;
                    temp_im <= W_im31;
                    end
			(START_CNT+32) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+33) : begin
                    temp_re <= W_re6;
                    temp_im <= W_im6;
                    end   
			(START_CNT+34) : begin
                    temp_re <= W_re10;
                    temp_im <= W_im10;
                    end
			(START_CNT+35) : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end
			(START_CNT+36) : begin
                    temp_re <= W_re18;
                    temp_im <= W_im18;
                    end   
			(START_CNT+37) : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end   
			(START_CNT+38) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+39) : begin
                    temp_re <= W_re30;
                    temp_im <= W_im30;
                    end
			(START_CNT+40) : begin
                    temp_re <= W_re2;
                    temp_im <= W_im2;
                    end   
			(START_CNT+41) : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
			(START_CNT+42) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
			(START_CNT+43) : begin
                    temp_re <= W_re14;
                    temp_im <= W_im14;
                    end
			(START_CNT+44) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+45) : begin
                    temp_re <= W_re22;
                    temp_im <= W_im22;
                    end   
			(START_CNT+46) : begin
                    temp_re <= W_re26;
                    temp_im <= W_im26;
                    end
			(START_CNT+47) : begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
			(START_CNT+48) : begin
                    temp_re <= W_re2;
                    temp_im <= W_im2;
                    end   
			(START_CNT+49) : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
			(START_CNT+50) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
			(START_CNT+51) : begin
                    temp_re <= W_re14;
                    temp_im <= W_im14;
                    end
			(START_CNT+52) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+53) : begin
                    temp_re <= W_re22;
                    temp_im <= W_im22;
                    end   
			(START_CNT+54) : begin
                    temp_re <= W_re26;
                    temp_im <= W_im26;
                    end
			(START_CNT+55) : begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
			(START_CNT+56) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+57) : begin
                    temp_re <= W_re6;
                    temp_im <= W_im6;
                    end   
			(START_CNT+58) : begin
                    temp_re <= W_re10;
                    temp_im <= W_im10;
                    end
			(START_CNT+59) : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end
			(START_CNT+60) : begin
                    temp_re <= W_re18;
                    temp_im <= W_im18;
                    end   
			(START_CNT+61) : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end   
			(START_CNT+62) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+63) : begin
                    temp_re <= W_re30;
                    temp_im <= W_im30;
                    end
			(START_CNT+64) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+65) : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end   
			(START_CNT+66) : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
			(START_CNT+67) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+68) : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
			(START_CNT+69) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+70) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+71) : begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
			(START_CNT+72) : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
			(START_CNT+73) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+74) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+75) : begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
			(START_CNT+76) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+77) : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end   
			(START_CNT+78) : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
			(START_CNT+79) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+80) : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
			(START_CNT+81) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+82) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+83) : begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end
			(START_CNT+84) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+85) : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end   
			(START_CNT+86) : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
			(START_CNT+87) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+88) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+89) : begin
                    temp_re <= W_re12;
                    temp_im <= W_im12;
                    end   
			(START_CNT+90) : begin
                    temp_re <= W_re20;
                    temp_im <= W_im20;
                    end
			(START_CNT+91) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+92) : begin
                    temp_re <= W_re4;
                    temp_im <= W_im4;
                    end   
			(START_CNT+93) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+94) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+95) : begin
                    temp_re <= W_re28;
                    temp_im <= W_im28;
                    end 
			(START_CNT+96) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+97) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
			(START_CNT+98) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
			(START_CNT+99) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+100) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+101) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+102) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+103) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+104) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+105) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+106) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+107) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+108) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+109) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
			(START_CNT+110) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
			(START_CNT+111) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+112) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+113) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+114) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+115) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end
			(START_CNT+116) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+117) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
			(START_CNT+118) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
			(START_CNT+119) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+120) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+121) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end   
			(START_CNT+122) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end
			(START_CNT+123) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+124) : begin
                    temp_re <= W_re8;
                    temp_im <= W_im8;
                    end   
			(START_CNT+125) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+126) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+127) : begin
                    temp_re <= W_re24;
                    temp_im <= W_im24;
                    end 
			(START_CNT+128) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+129) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+130) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+131) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+132) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+133) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+134) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+135) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+136) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+137) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+138) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+139) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+140) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+141) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+142) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+143) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+144) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+145) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+146) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+147) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+148) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+149) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+150) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+151) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+152) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+153) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+154) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end
			(START_CNT+155) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+156) : begin
                    temp_re <= W_re16;
                    temp_im <= W_im16;
                    end   
			(START_CNT+157) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end   
			(START_CNT+158) : begin
                    temp_re <= W_re0;
                    temp_im <= W_im0;
                    end
			(START_CNT+159) : begin
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
    
    assign data_out_re = $signed({buf_re[BW+12],buf_re[BW+8:10]});
    assign data_out_im = $signed({buf_im[BW+12],buf_im[BW+8:10]});
    assign data_out = $signed({data_out_re,data_out_im});

endmodule
