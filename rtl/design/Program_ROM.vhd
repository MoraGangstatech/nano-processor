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

            -- 10-1 = 9
            "100010001010", -- 0 -- MOVI R1,10
            "100100000001", -- 1 -- MOVI R2,1
            "010100000000", -- 2 -- NEG R2
            "000010100000", -- 3 -- ADD R1,R2
            "110000000000", -- 4 -- JZR R0,0
            "000000000000", -- 5 
            "000000000000", -- 6 
            "000000000000" -- 7 

            --       -- 1+2+3+4 = 10
            --       "100010000001", -- 0 -- MOVI R1,1
            --       "100100000010", -- 1 -- MOVI R2,2
            --       "100110000011", -- 2 -- MOVI R3,3
            --       "101000100100", -- 3 -- MOVI R4,4
            --       "000010100000", -- 4 -- ADD R1,R2
            --       "000010110000", -- 5 -- ADD R1,R3
            --       "000011000000", -- 6 -- ADD R1,R4
            --       "110000000000"  -- 7 -- JZR R0,0

            -- 		--count 10 to 0
            --       "100010001010", --0  --  MOVI R1,10
            --       "100100000001", --1  --  MOVI R2,01
            --       "010100000000", --2  --  NEG R2
            --       "000010100000", --3  --  ADD R1,R2
            --       "110010000111", --4  --  JZR R1,7
            --       "110000000011", --5  --  JZR R0,3
            --       "110010000111", --6  --  JZR R1,7 
            --       "110010000110"  --7  --  JZR R1,6                      
      );

BEGIN
      Instruction <= instruction_ROM(to_integer(unsigned(MemoryAddress)));

END Behavioral;