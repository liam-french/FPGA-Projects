library ieee;
use ieee.std_logic_1164.all;

entity state_machine is
    port(
        clk, x: in std_logic;
        z: out std_logic
    );
end state_machine;

architecture rtl of state_machine is

signal a, b, Anext, Bnext: std_logic :='0';

begin
    Anext <= x and (a xor b);
    Bnext <= not x or (a and b);
    z <= a and b and x;
    process(clk, x);
    begin
        if(clk'event and clk='0') then
            a <= Anext;
            b <= Bnext;
        end if;
    end process;
end rtl;
    