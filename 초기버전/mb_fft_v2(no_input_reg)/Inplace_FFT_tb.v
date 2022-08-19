`define p 2
`timescale 1ns/1ps


module Inplace_FFT_tb();
    
    reg nrst, clk, start, valid;
    wire [15:0] inReal, inImag;
    wire output_start;
    wire [15:0] outReal0, outImag0, outReal1, outImag1;


    reg [15:0] input_re[63:0];
    reg [15:0] input_im[63:0];

    reg [15:0] output_re0[31:0];
    reg [15:0] output_re1[31:0];
    reg [15:0] output_im0[31:0];
    reg [15:0] output_im1[31:0];

    integer clkcnt;

    Inplace_FFT Inplace_FFT(nrst, clk, start, valid, inReal, inImag, output_start, outReal0, outImag0, outReal1, outImag1);


    always
        #(`p/2) clk = !clk;

    always@(negedge clk)
        clkcnt = clkcnt +1;

    initial begin
        clk = 0;
        nrst = 0;
        clkcnt = -103;
        start = 0;
        $readmemb("binary_in_real.txt", input_re);    
        $readmemb("binary_in_imag.txt", input_im);

        #(100*`p) start = 1'b1;
        #(`p/2+1) nrst = 1; valid=1;
    end

    assign inReal = clkcnt > -2? input_re[clkcnt+1] : 0;
    assign inImag = clkcnt > -2? input_im[clkcnt+1] : 0;

    always @ (posedge clk) begin
        output_re0[clkcnt-226] <= outReal0;
        output_re1[clkcnt-226] <= outReal1;
        output_im0[clkcnt-226] <= outImag0;
        output_im1[clkcnt-226] <= outImag1;
    end


    integer dumpfile, i;

    initial begin
        #(400*`p +1) dumpfile = $fopen("binary_out_real.txt","w");
        for(i = 0; i<32;i=i+1)begin
                $fwrite(dumpfile,"%d\n", $signed(output_re0[i]));
                $fwrite(dumpfile,"%d\n",$signed(output_re1[i]));
        end
        $fclose(dumpfile);
        dumpfile = $fopen("binary_out_imag.txt","w");
        for(i = 0; i<32;i=i+1)begin
                $fwrite(dumpfile,"%d\n",$signed(output_im0[i]));
                $fwrite(dumpfile,"%d\n",$signed(output_im1[i]));
        end
        $fclose(dumpfile);
        $stop;
    end
endmodule