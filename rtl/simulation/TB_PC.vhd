LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY TB_PC IS
END TB_PC;

ARCHITECTURE Behavioral OF TB_PC IS
    COMPONENT PC
        PORT (
            Reset : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Memory_select : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL Reset : STD_LOGIC;
    SIGNAL Clk : STD_LOGIC := '0';
    SIGNAL D : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL Memory_select : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN
    UUT : PC
    PORT MAP (
        Reset => Reset,
        Clk => Clk,
        D => D,
        Memory_select => Memory_select
    );
    
    process
        begin
            Clk <= not Clk;
            wait for 10 ns; -- Assuming a 10 ns clock period
        end process;
    
    PROCESS
    BEGIN
    --Index 220220V -- 110 101 110 000 111 100
        Reset <= '0';
            
        -- Test cases 1
        D <= "100";
        WAIT FOR 100 ns;
        
        -- Test cases 2
        D <= "111";
        WAIT FOR 100 ns;
        
        -- Test cases 3
        D <= "000";
        WAIT FOR 100 ns;
        
        -- Test cases 4
        D <= "110";
        WAIT FOR 100 ns;
        
        Reset <= '1'; --reset
        
        WAIT;
    END PROCESS Stimulus;
END Behavioral;
