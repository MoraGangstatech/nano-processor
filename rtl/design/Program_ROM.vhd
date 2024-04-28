LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

USE IEEE.NUMERIC_STD.ALL;

ENTITY Program_ROM IS
      PORT (
            MemoryAddress : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR (13 DOWNTO 0));
END Program_ROM;

ARCHITECTURE Behavioral OF Program_ROM IS

      TYPE rom_type IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(13 DOWNTO 0);
      -- vhdl-linter-disable-next-line unused
      SIGNAL instruction_ROM : rom_type := (

            "11111110000100", -- 0 -- MOVI R7,4
            "11111100000010", -- 1 -- MOVI R6,2
            "00101111100000", -- 2 -- ADD R7,R6
            "11111010000011", -- 3 -- MOVI R5,3
            "00111111010000", -- 4 -- MOVA R7,R5
            "01101111100100", -- 5 -- SUB R7, R6 (check bit)

            "11111100001111", -- 6 -- MOVI R6,15
            "00001111100000", -- 7 -- AND R7, R6
            "01001111100000", -- 8 -- ANDN R7, R6
            "00011111100000", -- 9 -- OR R7, R6
            "01011111100000", -- 10 -- ORN R7, R6

            "10101000001111", -- 11 -- JZR R4, 15
            "00000000000000", -- 13
            "11101111010000", -- 13 -- JALTB R7, R5, 0
            "00000000000000", -- 14
            "10011100001101" -- 15 -- JNZR R6, 13
      );

BEGIN

      Instruction <= instruction_ROM(to_integer(unsigned(MemoryAddress)));

END Behavioral;