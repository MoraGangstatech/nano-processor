LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Program_ROM IS

END TB_Program_ROM;

ARCHITECTURE Behavioral OF TB_Program_ROM IS

    COMPONENT Program_ROM IS
        PORT (
            MemoryAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL MemoryAddress : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Instruction : STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN

    UUT : Program_ROM
    PORT MAP(
        MemoryAddress => MemoryAddress,
        Instruction => Instruction
    );

    PROCESS
    BEGIN

        MemoryAddress <= "000";
        WAIT FOR 100 ns;

        MemoryAddress <= "001";
        WAIT FOR 100 ns;

        MemoryAddress <= "010";
        WAIT FOR 100 ns;

        MemoryAddress <= "011";
        WAIT FOR 100 ns;

        MemoryAddress <= "100";
        WAIT FOR 100 ns;

        MemoryAddress <= "101";
        WAIT FOR 100 ns;

        MemoryAddress <= "110";
        WAIT FOR 100 ns;

        MemoryAddress <= "111";
        WAIT FOR 100 ns;

        WAIT;

    END PROCESS;

END Behavioral;