LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY HA IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        S : OUT STD_LOGIC;
        C : OUT STD_LOGIC);
END HA;

ARCHITECTURE Behavioral OF HA IS

BEGIN

    S <= A XOR B;
    C <= A AND B;

END Behavioral;