LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Decoder_2_to_4 IS
    PORT (
        I : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        EN : IN STD_LOGIC;
        Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Decoder_2_to_4;

ARCHITECTURE Behavioral OF Decoder_2_to_4 IS

BEGIN

    Y(0) <= EN AND NOT(I(0)) AND NOT(I(1));
    Y(1) <= EN AND NOT(I(1)) AND I(0);
    Y(2) <= EN AND I(1) AND NOT(I(0));
    Y(3) <= EN AND I(0) AND I(1);

END Behavioral;