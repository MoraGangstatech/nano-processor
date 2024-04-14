library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Adder_3bit is
end TB_Adder_3bit;

architecture Behavioral of TB_Adder_3bit is

    component Adder_3bit is
        port (
            A : in STD_LOGIC_VECTOR (2 DOWNTO 0);
            B : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    end component;

    signal A : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal B : STD_LOGIC;
    signal S : STD_LOGIC_VECTOR(2 DOWNTO 0);

begin

    UUT : Adder_3bit
    port map (
        A => A,
        B => B,
        S => S
    );


    process
    begin
    --Index 220578A -- 110 101 110 110 100 010
        -- Test case 1
        A <= "010"; -- 2
        B <= '1';   -- 1
        wait for 100 ns;

        -- Test case 2
        A <= "100"; -- 4
        B <= '0';   -- 0
        wait for 100 ns;

        -- Test case 3
        A <= "110"; -- 6
        B <= '1';   -- 1
        wait for 100 ns;
        
        -- Test case 4
        A <= "101"; -- 5
        B <= '1';   -- 1
        wait for 100 ns;
        
        wait;
    end process;

end Behavioral;
