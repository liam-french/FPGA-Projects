library ieee;
use ieee.std_logic_1164.all;

entity FA4_tb is
end FA4_tb;

architecture test of FA4_tb is
    component FA4
        port(
            A, B : in std_logic_vector(3 downto 0);
            Cin : in std_logic;
            S : out std_logic_vector(3 downto 0);
            Cout : out std_logic
        );
    end component;

    signal A, B : std_logic_vector(3 downto 0);
    signal Cin : std_logic;
    signal S : std_logic_vector(3 downto 0);
    signal Cout : std_logic;

begin
    -- Instantiate the 4-bit full adder
    UUT: FA4 port map(A, B, Cin, S, Cout);

    -- Test process
    process
    begin
        A <= "0000";
        B <= "0000";
        Cin <= '0';
        wait for 10 ns;

        A <= "0000";
        B <= "0001";
        Cin <= '0';
        wait for 10 ns;

        A <= "0001";
        B <= "0001";
        Cin <= '0';
        wait for 10 ns;

        A <= "1111";
        B <= "1111";
        Cin <= '0';
        wait for 10 ns;

        A <= "1111";
        B <= "1111";
        Cin <= '1';
        wait for 10 ns;

        A <= "0000";
        B <= "0000";
        Cin <= '1';
        wait for 10 ns;

        A <= "0000";
        B <= "0001";
        Cin <= '1';
        wait for 10 ns;

        A <= "0001";
        B <= "0001";
        Cin <= '1';
        wait for 10 ns;

        A <= "1111";
        B <= "1111";
        Cin <= '1';
        wait for 10 ns;

        A <= "1111";
        B <= "1111";
        Cin <= '0';
        wait for 10 ns;

        A <= "0000";
        B <= "0000";
        Cin <= '0';
        wait for 10 ns;

        A <= "0000";
        B <= "0001";
        Cin <= '0';
        wait for 10 ns;

        A <= "0001";
        B <= "0001";
        Cin <= '0';
        wait for 10 ns;

        A <= "1111";
        B <= "1111";
        Cin <= '0';
        wait for 10 ns;

        A <= "1111";
        B <= "1111";
        Cin <= '1';
        wait for 10 ns;

        A <= "0000";
        B <= "0000";
        Cin <= '1';
        wait for 10 ns;

        A <= "0000";
        B <= "0001";
        Cin <= '1';
        wait for 10 ns;
    end process;
end test; 