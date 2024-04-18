LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Mux_8_4bit IS

END TB_Mux_8_4bit;

ARCHITECTURE behavior OF TB_Mux_8_4bit IS

    COMPONENT Mux_8_4bit
        PORT (
            Reg_Sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            R0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            R1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            R2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            R3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            R4 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            R5 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            R6 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            R7 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL Reg_Sel : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL R0 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R2 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R3 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R4 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R5 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R6 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R7 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL Output : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    UUT : Mux_8_4bit
    PORT MAP(
        Reg_Sel => Reg_Sel,
        R0 => R0,
        R1 => R1,
        R2 => R2,
        R3 => R3,
        R4 => R4,
        R5 => R5,
        R6 => R6,
        R7 => R7,
        Output => Output
    );

    PROCESS
        --Index 220627B -- 11 0101 1101 1101 0011
        --Index 220523D -- 11 0101 1101 0110 1011
        --Index 220220V -- 11 0101 1100 0011 1100
        --Index 220578A -- 11 0101 1101 1010 0010
    BEGIN

        R0 <= "0011";
        R1 <= "1101";
        R2 <= "0101";
        R3 <= "0110";
        R4 <= "1011";
        R5 <= "1100";
        R6 <= "0010";
        R7 <= "1010";

        -- Test case 1: Select input R0
        Reg_Sel <= "000";
        WAIT FOR 100 ns;

        -- Test case 2: Select input R1
        Reg_Sel <= "001";
        WAIT FOR 100 ns;

        -- Test case 3: Select input R2
        Reg_Sel <= "010";
        WAIT FOR 100 ns;

        -- Test case 4: Select input R3
        Reg_Sel <= "011";
        WAIT FOR 100 ns;

        -- Test case 5: Select input R4
        Reg_Sel <= "100";
        WAIT FOR 100 ns;

        -- Test case 6: Select input R5
        Reg_Sel <= "101";
        WAIT FOR 100 ns;

        -- Test case 7: Select input R6
        Reg_Sel <= "110";
        WAIT FOR 100 ns;

        -- Test case 8: Select input R7
        Reg_Sel <= "111";
        WAIT FOR 100 ns;

    END PROCESS;

END;