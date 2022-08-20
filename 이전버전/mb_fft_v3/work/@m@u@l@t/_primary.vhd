library verilog;
use verilog.vl_types.all;
entity MULT is
    generic(
        BW              : integer := 32
    );
    port(
        clk             : in     vl_logic;
        cnt             : in     vl_logic_vector(7 downto 0);
        data_in         : in     vl_logic_vector;
        data_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BW : constant is 1;
end MULT;
