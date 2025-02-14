library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1_vec is
    port (
        sel : in  std_logic_vector(1 downto 0);
        in0 : in  std_logic_vector(3 downto 0);
        in1 : in  std_logic_vector(3 downto 0);
        in2 : in  std_logic_vector(3 downto 0);
        in3 : in  std_logic_vector(3 downto 0);
        output : out std_logic_vector(3 downto 0)
    );
end mux_4x1_vec;

architecture impl of mux_4x1_vec is
begin
    process(sel, in0, in1, in2, in3)
    begin
    case sel is
            when "00" =>
                output <= in0;
            when "01" =>
                output <= in1;
            when "10" =>
                output <= in2;
            when "11" =>
                output <= in3;
            when others =>
                output <= (others => '0');  -- Default case (optional)
        end case;
    end process;
end impl;