library verilog;
use verilog.vl_types.all;
entity controlblock is
    generic(
        input_state     : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        stage1_1_state  : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi1);
        stage1_state    : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi0);
        stage2_state    : vl_logic_vector(0 to 2) := (Hi0, Hi1, Hi1);
        stage3_state    : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi0);
        stage4_state    : vl_logic_vector(0 to 2) := (Hi1, Hi0, Hi1);
        stage5_state    : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi0);
        stage6_state    : vl_logic_vector(0 to 2) := (Hi1, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        valid           : in     vl_logic;
        nrst            : in     vl_logic;
        cnt             : in     vl_logic_vector(7 downto 0);
        input_done      : out    vl_logic;
        output_start    : out    vl_logic;
        swap0_en        : out    vl_logic;
        swap1_en        : out    vl_logic;
        we_b0           : out    vl_logic;
        re_b0           : out    vl_logic;
        we_b1           : out    vl_logic;
        re_b1           : out    vl_logic;
        waddr_b0        : out    vl_logic_vector(4 downto 0);
        raddr_b0        : out    vl_logic_vector(4 downto 0);
        waddr_b1        : out    vl_logic_vector(4 downto 0);
        raddr_b1        : out    vl_logic_vector(4 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of input_state : constant is 1;
    attribute mti_svvh_generic_type of stage1_1_state : constant is 1;
    attribute mti_svvh_generic_type of stage1_state : constant is 1;
    attribute mti_svvh_generic_type of stage2_state : constant is 1;
    attribute mti_svvh_generic_type of stage3_state : constant is 1;
    attribute mti_svvh_generic_type of stage4_state : constant is 1;
    attribute mti_svvh_generic_type of stage5_state : constant is 1;
    attribute mti_svvh_generic_type of stage6_state : constant is 1;
end controlblock;
