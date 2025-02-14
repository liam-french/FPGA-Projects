library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_bit_tb is
end mux_2x1_bit_tb;
architecture test of mux_2x1_bit_tb is
    component mux_2x1_bit is
        port (
                sel : in  std_logic;
                in0 : in  std_logic;
                in1 : in  std_logic;
                output : out std_logic
            );
    end component;

    signal sel : std_logic := '0';
    signal in0 : std_logic := '0';
    signal in1 : std_logic := '0';
    signal output : std_logic;

begin
    UUT: mux_2x1_bit port map(sel, in0, in1, output);

    in0 <= not in0 after 5 ns;
    in1 <= not in1 after 10 ns;
    sel <= not sel after 20 ns;
end test;

