library ieee;
use ieee.std_logic_1164.all;

entity FA_tb is
end FA_tb;

architecture test of FA_tb is
    component FA
        port(
            A, B : in std_logic;
            Cin : in std_logic;
            S : out std_logic;
            Cout : out std_logic
        );
    end component;

    signal A, B : std_logic;
    signal Cin : std_logic;
    signal S : std_logic;
    signal Cout : std_logic;

begin
    UUT: FA port map(A, B, Cin, S, Cout);

    A <= not A after 5 ns;
    B <= not B after 10 ns;
    Cin <= not Cin after 20 ns;
end test; 