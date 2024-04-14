----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 08:36:57 PM
-- Design Name: 
-- Module Name: TB_NP - Behavioral
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

entity TB_NanoProcessor is
--  Port ( );
end TB_NanoProcessor;

architecture Behavioral of TB_NanoProcessor is

component NanoProcessor
    Port (
       Clk : IN STD_LOGIC;
       Reset : IN STD_LOGIC;
       Zero : OUT STD_LOGIC;
       Overflow : OUT STD_LOGIC;
       Seven_Seg_Out : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
       LED_Out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
       Anode: out STD_LOGIC_VECTOR(3 downto 0));
end component;

signal Seven_Seg_Out :STD_LOGIC_VECTOR (6 downto 0);
signal Reset, Zero, Overflow : STD_LOGIC;
signal Clk : STD_LOGIC := '0';
signal LED_Out : STD_LOGIC_VECTOR (3 DOWNTO 0);

begin

UUT: NanoProcessor PORT MAP(
    Clk => Clk,
    Reset => Reset,
    Zero => Zero,
    Overflow => Overflow,
    Seven_Seg_Out => Seven_Seg_Out,
    LED_Out => LED_Out
);
    process
    begin
        Clk <= not Clk;
        wait for 50 ns; -- Assuming a 50 ns clock period
    end process;

    process
    begin
      Reset <= '1';
      wait for 10 ns; -- Assuming a 10 ns reset duration
      Reset <= '0';
      wait;
      
    end process;

end Behavioral;
