LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder_Subtractor_4bit IS
    PORT (
        A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        M : IN STD_LOGIC; -- 1 - sub
        S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC);
END Adder_Subtractor_4bit;

ARCHITECTURE Behavioral OF Adder_Subtractor_4bit IS

    COMPONENT FA
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL FA0_C, FA1_C, FA2_C, B0, B1, B2, B3 : STD_LOGIC;
    SIGNAL S_out : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    FA_0 : FA
    PORT MAP(
        A => A(0),
        B => B0,
        C_in => M,
        S => S_out(0),
        C_out => FA0_C);

    FA_1 : FA
    PORT MAP(
        A => A(1),
        B => B1,
        C_in => FA0_C,
        S => S_out(1),
        C_out => FA1_C);

    FA_2 : FA
    PORT MAP(
        A => A(2),
        B => B2,
        C_in => FA1_C,
        S => S_out(2),
        C_out => FA2_C);

    FA_3 : FA
    PORT MAP(
        A => A(3),
        B => B3,
        C_in => FA2_C,
        S => S_out(3));

    B0 <= B(0) XOR M;
    B1 <= B(1) XOR M;
    B2 <= B(2) XOR M;
    B3 <= B(3) XOR M;

    S <= S_out;

    Zero <= NOT (S_out(0) OR S_out(1) OR S_out(2) OR S_out(3));

    Overflow <= (B3 AND A(3) AND NOT FA2_C) OR (NOT B3 AND NOT A(3) AND FA2_C);

END Behavioral;