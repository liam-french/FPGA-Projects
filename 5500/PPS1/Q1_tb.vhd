entity test_nor5 is
end test_nor5;

architecture test of test_nor5 is
    -- Declare Component
    component nor5 is
        port (i1, i2, i3, i4, i5: in bit;
              o1: out bit);
    end component;

    signal A, B, C, D, E, F: bit;

begin
    -- Instantiate Module
    m1: nor5 port map(A, B, C, D, E, F);

    A <= not A after 5 ns;
    B <= not B after 10 ns;
    C <= not C after 20 ns;
    D <= not D after 40 ns;
    E <= not E after 80 ns;
end;