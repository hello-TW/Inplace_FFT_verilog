library verilog;
use verilog.vl_types.all;
entity Inplace_FFT is
    generic(
        BW              : integer := 16
    );
    port(
        nrst            : in     vl_logic;
        clk             : in     vl_logic;
        start           : in     vl_logic;
        valid           : in     vl_logic;
        inReal          : in     vl_logic_vector;
        inImag          : in     vl_logic_vector;
        outReal0        : out    vl_logic_vector;
        outImag0        : out    vl_logic_vector;
        outReal1        : out    vl_logic_vector;
        outImag1        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BW : constant is 1;
end Inplace_FFT;
