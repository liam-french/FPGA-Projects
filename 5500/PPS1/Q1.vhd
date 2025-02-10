entity nor2 is
    port (i1, i2: in bit; o1: out bit);
end nor2;

architecture impl of nor2 is
    begin
        o1 <= NOT (i1 or i2);
end impl;

entity nor5 is
    port (i1, i2, i3, i4, i5: in bit; o1: out bit);
end nor5;

architecture impl of nor5 is
    component nor2 is
        port (i1, i2: in bit;
              o1: out bit);
    end component;

    signal s1, s2, s3, s4, s5, s6 : bit;
    begin
        U1: nor2 port map(i1, i2, s1);
        U2: nor2 port map(i3, i4, s2);
        U3: nor2 port map(s1, s1, s3);
        U4: nor2 port map(s2, s2, s4);
        U5: nor2 port map(s3, i5, s5);
        U6: nor2 port map(s5, s5, s6);
        U7: nor2 port map(s4, s5, o1);
end impl;