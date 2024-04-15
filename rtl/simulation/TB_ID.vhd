----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 04:23:03 PM
-- Design Name: 
-- Module Name: TB_ID - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_ID is
--  Port ( );
end TB_ID;

architecture Behavioral of TB_ID is

component Instruction_Decoder
    Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0);
           Jump_Reg : in STD_LOGIC;
           Reg_En : out STD_LOGIC_VECTOR (2 downto 0);
           Reg_Sel_0 : out STD_LOGIC_VECTOR (2 downto 0);
           Value : out STD_LOGIC_VECTOR (3 downto 0);
           Load_Sel : out STD_LOGIC;
           Reg_Sel_1 : out STD_LOGIC_VECTOR (2 downto 0);
           Add_Sub : out STD_LOGIC;
           Jump_Flag : out STD_LOGIC;
           Jump_Addr : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal Jump_Addr, Reg_Sel_1, Reg_Sel_0, Reg_En :STD_LOGIC_VECTOR (2 downto 0);
signal Value :STD_LOGIC_VECTOR (3 downto 0);
signal Instruction :STD_LOGIC_VECTOR (11 downto 0);
signal Jump_Reg, Load_Sel, Add_Sub, Jump_Flag : STD_LOGIC;

begin

UUT: Instruction_Decoder PORT MAP(
    Instruction => Instruction,
    Jump_Reg => Jump_Reg,
    Reg_En => Reg_En,
    Reg_Sel_0 => Reg_Sel_0,
    Value => Value,
    Load_Sel => Load_Sel,
    Reg_Sel_1 => Reg_Sel_1,
    Add_Sub => Add_Sub,
    Jump_Flag => Jump_Flag,
    Jump_Addr => Jump_Addr
);

process
  begin
  Jump_Reg <= '0';
  Instruction <= "100010001010";
  WAIT FOR 100 ns; -- after 100 ns change inputs
  
  Instruction <= "100100000001";
  WAIT FOR 100 ns; -- after 100 ns change inputs
  
  Instruction <= "010100000000";
  WAIT FOR 100 ns; -- after 100 ns change inputs
  
  Instruction <= "000010100000";
  WAIT FOR 100 ns; -- after 100 ns change inputs
  
  Instruction <= "110000000000";
  WAIT FOR 100 ns; -- after 100 ns change inputs
  

    
  WAIT; -- will wait forever
  end process;

end Behavioral;
