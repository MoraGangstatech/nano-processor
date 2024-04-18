LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Tri_State_4bit IS
    PORT (
        En : IN STD_LOGIC;
        I : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        O : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END ENTITY Tri_State_4bit;

ARCHITECTURE Behavioral OF Tri_State_4bit IS
BEGIN

    PROCESS (En, I)
    BEGIN

        IF En = '1' THEN
            O <= I;
        ELSE
            O <= "ZZZZ"; -- High impedance state
        END IF;

    END PROCESS;

END ARCHITECTURE Behavioral;