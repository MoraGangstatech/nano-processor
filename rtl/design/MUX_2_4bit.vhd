
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2_4bit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B: in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC; -- 1 A
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_2_4bit;

architecture Behavioral of MUX_2_4bit is

component Tri_State_4bit
port (
      En : in std_logic;
      I : in STD_LOGIC_VECTOR (3 downto 0);
      O : out STD_LOGIC_VECTOR (3 downto 0)
      );
end component;

signal Not_S : STD_LOGIC;

begin

Not_S <= not S;

Tri_State_Buffer_A: Tri_State_4bit 
port map (En => S, 
          I => A,
          O => Q);
Tri_State_Buffer_B: Tri_State_4bit 
port map (En => Not_S, 
          I => B, 
          O => Q);

end Behavioral;
