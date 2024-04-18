LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Tri_State IS
    PORT (
        I : IN STD_LOGIC;
        O : OUT STD_LOGIC;
        En : IN STD_LOGIC);
END Tri_State;

ARCHITECTURE Behavioral OF Tri_State IS

BEGIN

    O <= (I) WHEN En = '1' ELSE
        'Z';

END Behavioral;