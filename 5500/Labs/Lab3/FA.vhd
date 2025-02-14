library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA is
    port(
        A, B, Cin : in std_logic;
        S, Cout : out std_logic
    );
end FA;

architecture impl of FA is
begin
    S <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A or B));
end impl;