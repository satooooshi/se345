library verilog;
use verilog.vl_types.all;
entity calcutator is
    port(
        hex0            : out    vl_logic_vector(6 downto 0);
        resetn          : in     vl_logic;
        clock           : in     vl_logic;
        key             : in     vl_logic_vector(3 downto 1);
        sw              : in     vl_logic_vector(9 downto 0);
        hex1            : out    vl_logic_vector(6 downto 0);
        hex2            : out    vl_logic_vector(6 downto 0);
        hex3            : out    vl_logic_vector(6 downto 0);
        hex4            : out    vl_logic_vector(6 downto 0);
        hex5            : out    vl_logic_vector(6 downto 0);
        led             : out    vl_logic_vector(9 downto 0)
    );
end calcutator;
