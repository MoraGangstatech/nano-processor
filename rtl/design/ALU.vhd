LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ALU IS
    PORT (
        Control : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        Carry : OUT STD_LOGIC;
        Sign : OUT STD_LOGIC);
END ALU;

ARCHITECTURE Behavioral OF ALU IS

    COMPONENT Adder_Subtractor_4bit
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            M : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC;
            Carry : OUT STD_LOGIC;
            Sign : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT Mux_4_1_4bit
        PORT (
            I0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            I1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            I2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            I3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Sel : IN STD_LOGIC_VECTOR (1 DOWNTO 0));
    END COMPONENT;

    SIGNAL B_mid, And_Res, OR_Res, Adder_out : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    Adder_Sub : Adder_Subtractor_4bit
    PORT MAP(
        A => A,
        B => B, -- for NEG command
        M => Control(2), --IF M=0 => Addition; IF M=1 => Subtraction;
        S => Adder_out,
        Overflow => Overflow,
        Zero => Zero,
        Carry => Carry,
        Sign => Sign);

    Mux : Mux_4_1_4bit
    PORT MAP(
        I0 => And_Res,
        I1 => OR_Res,
        I2 => Adder_out,
        I3 => B,
        Output => S,
        Sel => Control(1 DOWNTO 0));

    B_mid(0) <= B(0) XOR Control(2);-- 0 same, 1, flip
    B_mid(1) <= B(1) XOR Control(2);
    B_mid(2) <= B(2) XOR Control(2);
    B_mid(3) <= B(3) XOR Control(2);

    And_Res <= B_mid AND A;
    OR_Res <= B_mid OR A;

END Behavioral;