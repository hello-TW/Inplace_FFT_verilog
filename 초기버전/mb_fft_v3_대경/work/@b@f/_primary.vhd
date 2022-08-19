library verilog;
use verilog.vl_types.all;
entity BF is
    generic(
        BW              : integer := 16
    );
    port(
        Gr              : in     vl_logic_vector;
        Gi              : in     vl_logic_vector;
        Hr              : in     vl_logic_vector;
        Hi              : in     vl_logic_vector;
        Xr              : out    vl_logic_vector;
        Xi              : out    vl_logic_vector;
        Yr              : out    vl_logic_vector;
        Yi              : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BW : constant is 1;
end BF;
