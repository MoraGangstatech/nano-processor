library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Program_ROM is

end TB_Program_ROM;

architecture Behavioral of TB_Program_ROM is
    
    component Program_ROM is
        port (
            MemoryAddress : in std_logic_vector(2 downto 0);
            Instruction : out std_logic_vector(11 downto 0)
        );
    end component;

    signal MemoryAddress : std_logic_vector(2 downto 0);
    signal Instruction : std_logic_vector(11 downto 0);

begin

    UUT : Program_ROM
    port map (
        MemoryAddress => MemoryAddress,
        Instruction => Instruction
    );

    process
    begin
    
    MemoryAddress <= "000";
    wait for 100 ns;
    
    MemoryAddress <= "001";
    wait for 100 ns;
        
    MemoryAddress <= "010";
    wait for 100 ns;
            
    MemoryAddress <= "011";
    wait for 100 ns;
                
    MemoryAddress <= "100";
    wait for 100 ns;
    
    MemoryAddress <= "101";
    wait for 100 ns;
    
    MemoryAddress <= "110";
    wait for 100 ns;
        
    MemoryAddress <= "111";
    wait for 100 ns;

    wait;
    end process;

end Behavioral;
