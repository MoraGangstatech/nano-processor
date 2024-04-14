LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_MUX_2_3bit IS

END TB_MUX_2_3bit;

ARCHITECTURE behavior OF TB_MUX_2_3bit IS

    COMPONENT MUX_2_3bit
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            S : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL B : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL S : STD_LOGIC;
    SIGNAL Q : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN

    UUT : MUX_2_3bit
    PORT MAP (
        A => A,
        B => B,
        S => S,
        Q => Q
    );

PROCESS
    BEGIN
    --Index 220578A -- 110 101 110 110 100 010
        -- Test case 1: Select A
        S <= '0';
        A <= "010";
        B <= "100";
        wait for 100 ns;
        
        -- Test case 2: Select B
        S <= '1';
        wait for 100 ns;
        
        -- Test case 3: Change inputs A and B
        A <= "110";
        B <= "101";
        wait for 100 ns;
        
    END PROCESS;

END;
