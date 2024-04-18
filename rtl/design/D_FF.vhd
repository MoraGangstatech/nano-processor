LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY D_FF IS
    PORT (
        D : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Q : OUT STD_LOGIC;
        Qbar : OUT STD_LOGIC);
END D_FF;

ARCHITECTURE Behavioral OF D_FF IS

BEGIN

    PROCESS (Clk)
    BEGIN

        IF (rising_edge(Clk)) THEN
            IF Res = '1' THEN
                Q <= '0';
                Qbar <= '1';
            ELSE
                Q <= D;
                Qbar <= NOT D;
            END IF;
        END IF;

    END PROCESS;

END Behavioral;