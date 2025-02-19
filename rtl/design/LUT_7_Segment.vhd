LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LUT_7_Segment IS
    PORT (
        address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        data : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END LUT_7_Segment;

ARCHITECTURE Behavioral OF LUT_7_Segment IS

    TYPE rom_type IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(6 DOWNTO 0);
    -- vhdl-linter-disable-next-line unused
    SIGNAL sevenSegment_ROM : rom_type := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000", -- 9
        "0001000", -- a
        "0000011", -- b
        "1000110", -- c
        "0100001", -- d
        "0000110", -- e
        "0001110" -- f
    );

BEGIN

    data <= sevenSegment_ROM(to_integer(unsigned(address)));

END Behavioral;