library ieee;
use ieee.std_logic_1164.all;

entity test_10101 is
end test_10101;

architecture test of test_10101 is
    component sequence_detector_10101 is
        port(X, clk: in std_logic;
            Z: out std_logic);
    end component;

    signal i_X, i_clk: std_logic := '0';
    signal o_Z: std_logic;

begin
    m1: sequence_detector_10101 port map(i_X, i_clk, o_Z);

    i_clk <= not i_clk after 1 ns;
    i_X <= '0', '1' after 2 ns, '0' after 4 ns, '1' after 6 ns,
            '0' after 8 ns, '1' after 10 ns, '0' after 12 ns, '1' after 15 ns;
end test;