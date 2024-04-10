----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 03:45:37 PM
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY Instruction_Decoder IS
    PORT (
        Instruction : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
        Jump_Reg : IN STD_LOGIC;
        Reg_En : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Reg_Sel_0 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Value : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Load_Sel : OUT STD_LOGIC;
        Reg_Sel_1 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Add_Sub : OUT STD_LOGIC;
        Jump_Flag : OUT STD_LOGIC;
        Jump_Addr : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END Instruction_Decoder;

ARCHITECTURE Behavioral OF Instruction_Decoder IS

BEGIN

    Jump_Flag <= Instruction(11) AND Instruction(10) AND Jump_reg;
    Jump_Addr <= Instruction(2 DOWNTO 0);

    Reg_Sel_0 <= Instruction(9 DOWNTO 7);
    Reg_Sel_1 <= Instruction(6 DOWNTO 4);

    Reg_En <= Instruction(9 DOWNTO 7);

    value <= Instruction(3 DOWNTO 0);

    Load_Sel <= Instruction(11) AND (NOT Instruction(10));

    -- sub active only when NEG command actives
    Add_Sub <= (NOT Instruction(11)) AND Instruction(10);

END Behavioral;