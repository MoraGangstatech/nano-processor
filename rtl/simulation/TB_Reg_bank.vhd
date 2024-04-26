-- vhdl-linter-disable unused
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Reg_bank IS
END TB_Reg_bank;

ARCHITECTURE Behavioral OF TB_Reg_bank IS

    COMPONENT Reg_bank IS
        PORT (
            clk : IN STD_LOGIC;
            Reg_en : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            res : IN STD_LOGIC;
            out0 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out3 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out4 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out5 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out6 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Bank_en : IN STD_LOGIC
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL Reg_en : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL data_in : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL res : STD_LOGIC := '0';
    SIGNAL Bank_en : STD_LOGIC := '0';
    SIGNAL out0, out1, out2, out3, out4, out5, out6, out7 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    -- Instantiate the register bank
    UUT : Reg_bank
    PORT MAP(
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
        out7 => out7,
        Bank_en => Bank_en
    );

    -- Clock process
    PROCESS
    BEGIN

        clk <= NOT clk;
        WAIT FOR 10 ns; -- Assuming a 10 ns clock period

    END PROCESS;

    -- Stimulus process
    PROCESS
    BEGIN

        WAIT FOR 100 ns; -- Initial wait
        -- Apply stimulus here
        Reg_en <= "001"; -- Enable register 1
        data_in <= "1101"; -- Input data for registers
        res <= '0'; -- No reset
        WAIT FOR 100 ns;

        Reg_en <= "010"; -- Enable register 2
        data_in <= "1111"; -- Input data for registers
        WAIT FOR 100 ns;

        Reg_en <= "100"; -- Enable register 4
        data_in <= "0001"; -- Input data for registers
        WAIT FOR 100 ns;

        res <= '1'; --reset

        WAIT;

    END PROCESS;

END Behavioral;