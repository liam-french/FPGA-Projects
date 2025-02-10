library ieee;
use ieee.std_logic_1164.all;

entity shift_cell is
    port(
        from_left, from_right, from_load, s1, s0, clk, clr_L: in std_logic;
        q, q_n: out std_logic
    );
end shift_cell;

architecture a of shift_cell is
component dff is
    port(
        d, clr_L, clk: in std_logic;
        q, q_n: out std_logic
    );
end component;

component mux_4x1 is
    port(
        i1, i2, i3, i4, s0, s1: in std_logic;
        o1: out std_logic
    );
end component;

signal o_m: std_logic;

begin
    -- mux 00 hold 01 right shift 10 left shift 11 load
    m: mux_4x1 port map(q, from_right, from_left, from_load, s0, s1, o_m);
    d: dff port map(o_m, clr_L, clk, q, q_n);

end a;

-- Register with left and right shift and parallel load
entity reg_8_bit is
    port(
        A, B, C, D, E, F, G, H, s0, s1: in std_logic;
        );
end reg_8_bit;