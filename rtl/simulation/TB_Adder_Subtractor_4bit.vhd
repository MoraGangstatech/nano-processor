LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Adder_Subtractor_4bit IS
END TB_Adder_Subtractor_4bit;

ARCHITECTURE Behavioral OF TB_Adder_Subtractor_4bit IS

    COMPONENT Adder_Subtractor_4bit IS
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            M : IN STD_LOGIC; -- 1 for subtraction, 0 for addition
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            C_out : OUT STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A, B : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL M : STD_LOGIC;
    SIGNAL S : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL C_out, Zero, Overflow : STD_LOGIC;

BEGIN

    UUT : Adder_Subtractor_4bit
    PORT MAP(
        A => A,
        B => B,
        M => M,
        S => S,
        C_out => C_out,
        Zero => Zero,
        Overflow => Overflow
    );

    PROCESS
    BEGIN

        --Index 220627B -- 11 0101 1101 1101 0011
        -- Test addition
        A <= "0011"; -- 3
        B <= "1101"; -- 13
        M <= '0'; -- Addition
        WAIT FOR 100 ns;
        A <= "1101"; -- 13
        B <= "0101"; -- 5
        WAIT FOR 100 ns;
        A <= "0000"; -- 0
        B <= "0000"; -- 0
        WAIT FOR 100 ns;

        -- Test subtraction
        A <= "1101"; -- 13
        B <= "0101"; -- 5
        M <= '1'; -- Subtraction
        WAIT FOR 100 ns;
        A <= "1101"; -- 13
        B <= "0011"; -- 3
        WAIT FOR 100 ns;
        A <= "0000"; -- 0
        B <= "0000"; -- 0
        WAIT FOR 100 ns;

        WAIT;

    END PROCESS;

END Behavioral;