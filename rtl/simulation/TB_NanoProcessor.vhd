LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_NanoProcessor IS
    --  Port ( );
END TB_NanoProcessor;

ARCHITECTURE Behavioral OF TB_NanoProcessor IS

    COMPONENT NanoProcessor
        PORT (
            Clk : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC;
            Seven_Seg_Out : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            LED_Out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Anode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

    SIGNAL Seven_Seg_Out : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL Reset, Zero, Overflow : STD_LOGIC;
    SIGNAL Clk : STD_LOGIC := '0';
    SIGNAL LED_Out : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    UUT : NanoProcessor PORT MAP(
        Clk => Clk,
        Reset => Reset,
        Zero => Zero,
        Overflow => Overflow,
        Seven_Seg_Out => Seven_Seg_Out,
        LED_Out => LED_Out
    );

    PROCESS
    BEGIN

        Clk <= NOT Clk;
        WAIT FOR 50 ns; -- Assuming a 50 ns clock period

    END PROCESS;

    PROCESS
    BEGIN

        Reset <= '1';
        WAIT FOR 10 ns; -- Assuming a 10 ns reset duration
        Reset <= '0';
        WAIT;

    END PROCESS;

END Behavioral;