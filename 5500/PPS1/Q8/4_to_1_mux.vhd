library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1 is
    port(
        i1, i2, i3, i4, s0, s1: in std_logic;
        o1: out std_logic
    );
end mux_4x1;

architecture mux of mux_4x1 is
begin
    process(s0, s1)
    begin
        -- 00
        if (not s1 and not s0) then
            o1 <= i1;
        -- 01
        elsif (not s1 and s0) then
            o1 <= i2;
        -- 10
        elsif (s1 and not s0) then
            o1 <= i3;
        -- 11
        elsif (s1 and s0) then
            o1 <= i4;
        end if;
    end process;
end mux;