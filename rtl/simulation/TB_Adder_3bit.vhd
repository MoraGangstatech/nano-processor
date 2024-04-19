-- vhdl-linter-disable unused
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Adder_3bit IS
END TB_Adder_3bit;

ARCHITECTURE Behavioral OF TB_Adder_3bit IS

    COMPONENT Adder_3bit IS
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            B : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            C_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL A : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL B, C_out : STD_LOGIC;
    SIGNAL S : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    UUT : Adder_3bit
    PORT MAP(
        A => A,
        B => B,
        S => S,
        C_out => C_out
    );

    PROCESS
    BEGIN

        --Index 220578A -- 110 101 110 110 100 010
        -- Test case 1
        A <= "010"; -- 2
        B <= '1'; -- 1
        WAIT FOR 100 ns;

        -- Test case 2
        A <= "100"; -- 4
        B <= '0'; -- 0
        WAIT FOR 100 ns;

        -- Test case 3
        A <= "110"; -- 6
        B <= '1'; -- 1
        WAIT FOR 100 ns;

        -- Test case 4
        A <= "101"; -- 5
        B <= '1'; -- 1
        WAIT FOR 100 ns;

        WAIT;

    END PROCESS;

END Behavioral;