library ieee;
use ieee.std_logic_1164.all;

entity ssd is
    port (  A, B, C, D: std_logic;
        o_SSD: out std_logic_vector(6 downto 0));
end ssd;

architecture impl of ssd is
begin
    -- a
    o_SSD(6) <= (A and not B and not C) 
            or (not A and B and C)
            or (not B and not D)
            or (not A and C)
            or (A and not D)
            or (B and C);

    -- b
    o_SSD(5) <= (not A and not C and not D)
            or (not A and C and D)
            or (A and not C and D)
            or (not B and not D)
            or (not A and not B);

    -- c
    o_SSD(4) <= (not A and B and C)
            or (not B and not C)
            or (not C and D)
            or (A and not B)
            or (not A and D);

    -- d
    o_SSD(3) <= (B and not C and D)
            or (A and not C)
            or (B and C and not D)
            or (not B and C and D)
            or (not A and not B and not D);

    -- e
    o_SSD(2) <= (not B and not D)
            or (C and not D)
            or (A and C)
            or (A and B);

    -- f
    o_SSD(1) <= (not A and B and not C)
            or (not C and not D)
            or (B and not D)
            or (A and not B)
            or (A and C);

    -- g
    o_SSD(0) <= (not B and C)
            or (A and not B)
            or (A and D)
            or (C and not D)
            or (not A and B and not C);
end impl;