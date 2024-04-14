
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.NUMERIC_STD.ALL;

ENTITY Program_ROM IS
      PORT (
            MemoryAddress : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
END Program_ROM;

ARCHITECTURE Behavioral OF Program_ROM IS
      TYPE rom_type IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(11 DOWNTO 0);
      SIGNAL instruction_ROM : rom_type := (

        "101110000001", -- 0 -- MOVI R7,1
        "101100000010", -- 1 -- MOVI R6,2
        "101010000011", -- 2 -- MOVI R5,3
        "001111100000", -- 3 -- ADD R7,R6
        "001111010000", -- 4 -- ADD R7,R5
        "110000000000", -- 5 -- JZR R0,0
        "000000000000", -- 6 
        "000000000000"  -- 7 
             
      );

BEGIN
      Instruction <= instruction_ROM(to_integer(unsigned(MemoryAddress)));

END Behavioral;