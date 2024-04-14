library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Reg_bank is
end TB_Reg_bank;

architecture Behavioral of TB_Reg_bank is

    component Reg_bank is
        port (
            clk : in STD_LOGIC;
            Reg_en : in STD_LOGIC_VECTOR (2 DOWNTO 0);
            data : in STD_LOGIC_VECTOR (3 DOWNTO 0);
            res : in STD_LOGIC;
            out0 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
            out1 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
            out2 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
            out3 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
            out4 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
            out5 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
            out6 : out STD_LOGIC_VECTOR (3 DOWNTO 0);
            out7 : out STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    end component;

    signal clk : STD_LOGIC := '0';
    signal Reg_en : STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal data_in : STD_LOGIC_VECTOR(3 DOWNTO 0);
    signal res : STD_LOGIC := '0';
    signal out0, out1, out2, out3, out4, out5, out6, out7 : STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

    -- Instantiate the register bank
    UUT : Reg_bank
    port map (
        clk => clk,
        Reg_en => Reg_en,
        data => data_in,
        res => res,
        out0 => out0,
        out1 => out1,
        out2 => out2,
        out3 => out3,
        out4 => out4,
        out5 => out5,
        out6 => out6,
        out7 => out7
    );

    -- Clock process
    process
    begin
        clk <= not clk;
        wait for 10 ns; -- Assuming a 10 ns clock period
    end process;

    -- Stimulus process
    process
    begin
        wait for 100 ns; -- Initial wait
        -- Apply stimulus here
        Reg_en <= "001"; -- Enable register 1
        data_in <= "1101"; -- Input data for registers
        res <= '0'; -- No reset
        wait for 100 ns;

        Reg_en <= "010"; -- Enable register 2
        data_in <= "1111"; -- Input data for registers
        wait for 100 ns;
        
        Reg_en <= "100"; -- Enable register 4
        data_in <= "0001"; -- Input data for registers
        wait for 100 ns;
        
        res <= '1'; --reset

        wait;
    end process;
end Behavioral;
