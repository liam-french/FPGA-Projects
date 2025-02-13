library ieee;
use ieee.std_logic_1164.all;


entity ssd is
    port (  A, B, C, D: in std_logic;
        O: out std_logic_vector(6 downto 0));
end ssd;




architecture impl of ssd is
begin
    -- a
    O(0) <= not ((A and not B and not C) 
					or (not A and B and D)
					or (not B and not D)
					or (nxot A and C)
					or (A and not D)
					or (B and C));
    -- b
    O(1) <= not((not A and not C and not D)
            or (not A and C and D)
            or (A and not C and D)
            or (not B and not D)
            or (not A and not B));
    -- c
    O(2) <= not((not C and D)
            or (not A and B)
            or (A and not B)
            or (not A and D)
            or (not A and not C));
    -- d
    O(3) <= not((B and not C and D)
            or (A and not C)
            or (B and C and not D)
            or (not B and C and D)
            or (not A and not B and not D));
    -- e
   O(4) <= not((not B and not D)
            or (C and not D)
            or (A and C)
            or (A and B));
    -- f
    O(5) <= not((not A and B and not C)
            or (not C and not D)
            or (B and not D)
            or (A and not B)
            or (A and C));
    -- g
    O(6) <= not((not B and C)
            or (A and not B)
            or (A and D)
            or (C and not D)
            or (not A and B and not C));
end impl;
