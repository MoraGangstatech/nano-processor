LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Slow_Clk IS
    PORT (
        Clk_in : IN STD_LOGIC;
        Clk_out : OUT STD_LOGIC);
END Slow_Clk;

ARCHITECTURE Behavioral OF Slow_Clk IS

    SIGNAL count : INTEGER := 1;
    SIGNAL Clk_status : STD_LOGIC := '0';

BEGIN
    PROCESS (Clk_in) BEGIN
        IF (rising_edge(Clk_in)) THEN
            count <= count + 1;
            IF (count = 50000000) THEN
                Clk_status <= NOT (Clk_status);
                Clk_out <= Clk_status;
                count <= 1;
            END IF;
        END IF;
    END PROCESS;
END Behavioral;