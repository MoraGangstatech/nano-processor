
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MUX_2_3bit IS
    PORT (
        A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        S : IN STD_LOGIC; -- 1 - A
        Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END MUX_2_3bit;

ARCHITECTURE Behavioral OF MUX_2_3bit IS

    COMPONENT Tri_State
        PORT (
            I : IN STD_LOGIC;
            O : OUT STD_LOGIC;
            En : IN STD_LOGIC);
    END COMPONENT;

    SIGNAL Not_S : STD_LOGIC;

BEGIN

    Not_S <= NOT S;

    TS_0 : Tri_State
    PORT MAP(
        I => A(2),
        O => Q(2),
        En => S
    );

    TS_1 : Tri_State
    PORT MAP(
        I => A(1),
        O => Q(1),
        En => S
    );

    TS_2 : Tri_State
    PORT MAP(
        I => A(0),
        O => Q(0),
        En => S
    );

    TS_4 : Tri_State
    PORT MAP(
        I => B(2),
        O => Q(2),
        En => Not_S
    );

    TS_5 : Tri_State
    PORT MAP(
        I => B(1),
        O => Q(1),
        En => Not_S
    );

    TS_6 : Tri_State
    PORT MAP(
        I => B(0),
        O => Q(0),
        En => Not_S
    );

END Behavioral;