library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        nrst            : in     vl_logic;
        clk             : in     vl_logic;
        start           : in     vl_logic;
        valid           : in     vl_logic;
        cnt             : out    vl_logic_vector(7 downto 0)
    );
end counter;
