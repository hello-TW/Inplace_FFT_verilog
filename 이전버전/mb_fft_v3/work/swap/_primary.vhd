library verilog;
use verilog.vl_types.all;
entity swap is
    generic(
        BW              : integer := 32
    );
    port(
        swap_en         : in     vl_logic;
        in_data1        : in     vl_logic_vector;
        in_data2        : in     vl_logic_vector;
        out_data1       : out    vl_logic_vector;
        out_data2       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BW : constant is 1;
end swap;
