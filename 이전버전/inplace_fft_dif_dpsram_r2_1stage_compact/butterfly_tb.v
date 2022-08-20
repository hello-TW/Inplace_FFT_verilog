module butterfly_tb();

    parameter COMP_BW = 32;
    reg  [COMP_BW-1:0] G,H;
    wire [COMP_BW+1:0] T,Y;

    butterfly #(COMP_BW) u1(G,H,T,Y);

    initial begin

        G[COMP_BW-1:16] = 16'd1;
        G[15:0] = 16'd2;

        H[COMP_BW-1:16] = 16'd3;
        H[15:0] = 16'd4;
        #100;
    end

endmodule