library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_vec is
    port (
        sel : in  std_logic;
        in0 : in  std_logic_vector(3 downto 0);
        in1 : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(3 downto 0)
    );
end mux_2x1_vec;

architecture impl of mux_2x1_vec is
begin
    output <= in0 when sel = '0' else in1;
end impl;