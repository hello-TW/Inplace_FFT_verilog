library verilog;
use verilog.vl_types.all;
entity simple_dualport_RAM is
    generic(
        BW              : integer := 16
    );
    port(
        clk             : in     vl_logic;
        valid           : in     vl_logic;
        we              : in     vl_logic;
        re              : in     vl_logic;
        addr_w          : in     vl_logic_vector(4 downto 0);
        addr_r          : in     vl_logic_vector(4 downto 0);
        data_in         : in     vl_logic_vector;
        data_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BW : constant is 1;
end simple_dualport_RAM;
