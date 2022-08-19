module bit_slice_sat_tb();

    reg  [16:0] data_in;
    wire [15:0] data_out;

    bit_slice_sat #(16)bit_slice_sat(data_in, data_out);

    initial begin
        data_in = 17'sd34468; #50;
        
        data_in = -17'sd34468; #50;

        data_in = -17'sd3168; #50;
        
        data_in = -17'sd1; #50;
        data_in = -17'sd2; #50;
        
        data_in = 17'sd2; #50;
        data_in = 17'sd3; #50;
    end

endmodule