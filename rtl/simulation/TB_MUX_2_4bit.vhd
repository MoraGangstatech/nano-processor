-- vhdl-linter-disable unused
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_MUX_2_4bit IS

END TB_MUX_2_4bit;

ARCHITECTURE behavior OF TB_MUX_2_4bit IS

    COMPONENT MUX_2_4bit
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            S : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL B : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL S : STD_LOGIC;
    SIGNAL Q : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    UUT : MUX_2_4bit
    PORT MAP(
        A => A,
        B => B,
        S => S,
        Q => Q
    );

    PROCESS
    BEGIN

        --Index 220627B -- 11 0101 1101 1101 0011

        -- Test case 1: Select A
        S <= '0';
        A <= "0011";
        B <= "1101";
        WAIT FOR 100 ns;

        -- Test case 2: Select B
        S <= '1';
        WAIT FOR 100 ns;

        -- Test case 3: Change inputs A and B
        A <= "0101";
        B <= "0001";
        WAIT FOR 100 ns;

    END PROCESS;

END;