library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1_vec_tb is
end mux_2x1_vec_tb;
architecture test of mux_2x1_vec_tb is
    component mux_2x1_vec is
        port (
                sel : in  std_logic;
                in0 : in  std_logic_vector(3 downto 0);
                in1 : in  std_logic_vector(3 downto 0);
                output : out std_logic_vector(3 downto 0)
            );
    end component;

    signal sel : std_logic := '0';
    signal in0 : std_logic_vector(3 downto 0);
    signal in1 : std_logic_vector(3 downto 0);
    signal output : std_logic_vector(3 downto 0);

begin
    UUT: mux_2x1_vec port map(sel, in0, in1, output);

    in0 <= "0101";
    in1 <= "1010";
    sel <= not sel after 20 ns;
end test;