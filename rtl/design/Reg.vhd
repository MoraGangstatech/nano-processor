LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Reg IS
    PORT (
        En : IN STD_LOGIC;
        D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Reg;

ARCHITECTURE Behavioral OF Reg IS

BEGIN

    PROCESS (Clk, EN, RES)
    BEGIN
        IF (Res = '0') THEN
            IF (rising_edge(Clk)) THEN
                IF (EN = '1') THEN
                    Q <= D;
                END IF;
            END IF;
        ELSE
            Q <= "0000";
        END IF;
    END PROCESS;

END Behavioral;