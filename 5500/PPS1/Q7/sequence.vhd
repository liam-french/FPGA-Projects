library ieee;
use ieee.std_logic_1164.all;

entity sequence_detector_10101 is
    port(X, clk: in std_logic;
         Z: out std_logic);
end sequence_detector_10101;

architecture dataflow of sequence_detector_10101 is
    signal A, B, C, Anext, Bnext, Cnext: std_logic := '0';
begin
    process(clk)
    begin
        if (clk'event and clk='1') then
            A <= Anext;
            B <= Bnext;
            C <= Cnext;
        end if;
    end process;

    Anext <= (C and not X and (B or A)) or (A and not C and X);
    Bnext <= (not A and not B and C and not X) or (B and not C and X);
    Cnext <= X;
    Z <= A and C;
end dataflow;

