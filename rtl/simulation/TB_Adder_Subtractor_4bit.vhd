library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Adder_Subtractor_4bit is
end TB_Adder_Subtractor_4bit;

architecture Behavioral of TB_Adder_Subtractor_4bit is

    component Adder_Subtractor_4bit is
        port (
            A : in STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : in STD_LOGIC_VECTOR (3 DOWNTO 0);
            M : in STD_LOGIC; -- 1 for subtraction, 0 for addition
            S : out STD_LOGIC_VECTOR (3 DOWNTO 0);
            C_out : out STD_LOGIC;
            Zero : out STD_LOGIC;
            Overflow : out STD_LOGIC
        );
    end component;

    signal A, B : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal M : STD_LOGIC;
    signal S : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal C_out, Zero, Overflow : STD_LOGIC;

begin

    UUT : Adder_Subtractor_4bit
    port map (
        A => A,
        B => B,
        M => M,
        S => S,
        C_out => C_out,
        Zero => Zero,
        Overflow => Overflow
    );

    process
    begin
    --Index 220627B -- 11 0101 1101 1101 0011
        -- Test addition
        A <= "0011"; -- 3
        B <= "1101"; -- 13
        M <= '0';    -- Addition
        wait for 100 ns;
        A <= "1101"; -- 13
        B <= "0101"; -- 5
        wait for 100 ns;
        A <= "0000"; -- 0
        B <= "0000"; -- 0
        wait for 100 ns;

        -- Test subtraction
        A <= "1101"; -- 13
        B <= "0101"; -- 5
        M <= '1';    -- Subtraction
        wait for 100 ns;
        A <= "1101"; -- 13
        B <= "0011"; -- 3
        wait for 100 ns;
        A <= "0000"; -- 0
        B <= "0000"; -- 0
        wait for 100 ns;

        wait;
    end process;

end Behavioral;
