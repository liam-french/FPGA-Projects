library ieee;
use ieee.std_logic_1164.all;

entity FA4 is
    port(
        A, B : in std_logic_vector(3 downto 0);
        Cin : in std_logic;
        S : out std_logic_vector(3 downto 0);
        Cout : out std_logic
    );
end FA4;

architecture impl of FA4 is
    component FA
        port(
            A, B, Cin : in std_logic;
            S, Cout : out std_logic
        );
    end component;

    signal C : std_logic_vector(2 downto 0);

begin
    FA0: FA port map(A(0), B(0), Cin, S(0), C(0));
    FA1: FA port map(A(1), B(1), C(0), S(1), C(1));
    FA2: FA port map(A(2), B(2), C(1), S(2), C(2));
    FA3: FA port map(A(3), B(3), C(2), S(3), Cout);
end impl;