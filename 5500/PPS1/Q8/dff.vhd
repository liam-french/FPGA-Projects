library ieee;
use ieee.std_logic_1164.all;

entity dff is
    port(
        d, clr_L, clk: in std_logic;
        q, q_n: out std_logic
    );
end dff;

architecture rtl of dff is
begin
    signal q_temp: std_logic;
    process(clr_L, clk)
    begin
        if (clr_L='0') then 
        q_temp <= '0';
        elsif (clk'event and clk='1') then
            q_temp <= d;
        end if;
    end process;
    q <= q_temp;
    q_n <= not q_temp;
end;