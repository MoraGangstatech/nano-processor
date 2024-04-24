LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY PC IS
  PORT (
    Reset : IN STD_LOGIC;
    Clk : IN STD_LOGIC;
    D : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    Memory_select : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END PC;

ARCHITECTURE Behavioral OF PC IS

BEGIN

  PROCESS (Clk)
  BEGIN

    -- IF (rising_edge(Clk)) THEN
    --   IF (Reset = '1') THEN
    --     Memory_select <= "000";
    --   ELSE
    --     Memory_select <= D;
    --   END IF;
    -- END IF;
    IF (Res = '0') THEN
      IF (rising_edge(Clk)) THEN
        IF (EN = '1') THEN
          Memory_select <= D;
        END IF;
      END IF;
    ELSE
      Q <= "000";
    END IF;
  END PROCESS;

END Behavioral;