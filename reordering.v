module reordering #(
    parameter ADDR_WIDTH = 5
)
(
    input [ADDR_WIDTH-1:0] raddr,
    output [ADDR_WIDTH-1:0] raddr_sw
);
/*
    integer i;
    initial begin
        for(i=0; i<ADDR_WIDTH; i=i+1)
            raddr_sw[ADDR-i] = raddr[i];
    end
*/
    raddr_sw[4] <= raddr[0];
    raddr_sw[3] <= raddr[1];
    raddr_sw[2] <= raddr[2];
    raddr_sw[1] <= raddr[3];
    raddr_sw[0] <= raddr[4];
endmodule