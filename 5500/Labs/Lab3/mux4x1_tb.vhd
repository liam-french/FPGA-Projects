library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1_vec_tb is
end mux_4x1_vec_tb;
architecture test of mux_4x1_vec_tb is
    component mux_4x1_vec is
        port (
                sel : in  std_logic_vector(1 downto 0);
                in0 : in  std_logic_vector(3 downto 0);
                in1 : in  std_logic_vector(3 downto 0);
                in2 : in  std_logic_vector(3 downto 0);
                in3 : in  std_logic_vector(3 downto 0);
                output : out std_logic_vector(3 downto 0)
            );
    end component;

    signal sel : std_logic_vector(1 downto 0);
    signal in0 : std_logic_vector(3 downto 0);
    signal in1 : std_logic_vector(3 downto 0);
    signal in2 : std_logic_vector(3 downto 0);
    signal in3 : std_logic_vector(3 downto 0);
    signal output : std_logic_vector(3 downto 0);

begin
    UUT: mux_4x1_vec port map(sel, in0, in1, in2, in3, output);

    process
    begin
        in0 <= "0000";
        in1 <= "0001";
        in2 <= "0010";
        in3 <= "0011";
        sel <= "00";
        wait for 10 ns;

        sel <= "01";
        wait for 10 ns;

        sel <= "10";
        wait for 10 ns;

        sel <= "11";
        wait for 10 ns;
    end process;
end test;