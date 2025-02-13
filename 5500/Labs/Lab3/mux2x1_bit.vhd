library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_bit is
    port (
        sel : in  std_logic;
        in0 : in  std_logic;
        in1 : in  std_logic;
        output : out std_logic
    );
end mux_2x1_bit;

architecture impl of mux_2x1_bit is
begin
    output <= in0 when sel = '0' else in1;
end impl;