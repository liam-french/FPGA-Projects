library ieee;
use ieee.std_logic_1164.all;

entity test_SSD is
end test_SSD;

architecture test of test_SSD is
    component ssd is
        port ( A, B, C, D: in std_logic;
            o_SSD: out std_logic_vector(6 downto 0));
    end component;

    signal A, B, C, D: std_logic := '0';
    signal fout: std_logic_vector(6 downto 0);

begin
    m1: ssd port map(A, B, B, D, fout);

    A <= not A after 5 ns;
    B <= not B after 10 ns;
    C <= not C after 20 ns;
    D <= not D after 40 ns;
end;