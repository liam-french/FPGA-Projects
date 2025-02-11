library ieee;
use ieee.std_logic_1164.all;

entity subtractor is
    port(
        a, b, borrow_in: in std_logic;
        difference, borrow_out: out std_logic
    );
end subtractor;

architecture dataflow of subtractor is
begin
    difference <= a xor b xor borrow_in;
    borrow_out <= (not a and (b or borrow_in)) or (b and borrow_in);
end;