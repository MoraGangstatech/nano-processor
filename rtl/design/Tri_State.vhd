----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 04:54:55 PM
-- Design Name: 
-- Module Name: Tri_State - Behavioral
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

entity Tri_State is
    Port ( I : in STD_LOGIC;
           O : out STD_LOGIC;
           En : in STD_LOGIC);
end Tri_State;

architecture Behavioral of Tri_State is

begin

O <= (I) when En = '1' else 'Z'; 

end Behavioral;
