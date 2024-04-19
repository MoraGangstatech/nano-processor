LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux_8_to_1 IS
    PORT (
        S : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        Y : OUT STD_LOGIC);
END Mux_8_to_1;

ARCHITECTURE Behavioral OF Mux_8_to_1 IS

    COMPONENT Decoder_3_to_8
        PORT (
            I : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;

    SIGNAL temp1, temp2 : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN

    Decoder_3_to_8_1 : Decoder_3_to_8
    PORT MAP(
        I => S,
        Y => temp1);

    temp2(0) <= temp1(0) AND D(0);
    temp2(1) <= temp1(1) AND D(1);
    temp2(2) <= temp1(2) AND D(2);
    temp2(3) <= temp1(3) AND D(3);
    temp2(4) <= temp1(4) AND D(4);
    temp2(5) <= temp1(5) AND D(5);
    temp2(6) <= temp1(6) AND D(6);
    temp2(7) <= temp1(7) AND D(7);

    Y <= temp2(0) OR temp2(1) OR temp2(2) OR temp2(3) OR temp2(4) OR temp2(5) OR temp2(6) OR temp2(7);

END Behavioral;