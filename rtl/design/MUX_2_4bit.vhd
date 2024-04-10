library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2_4bit is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B: in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC; -- 1 A
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_2_4bit;

architecture Behavioral of MUX_2_4bit is

component Tri_State
    Port ( I : in STD_LOGIC;
           O : out STD_LOGIC;
           En : in STD_LOGIC);
end component;

signal Not_S : STD_LOGIC;

begin

Not_S <= not S;

TS_0 : Tri_State
port map( 
    I => A(3),
    O => Q(3),
    En => S
        );
        
TS_1 : Tri_State
port map( 
    I => A(2),
    O => Q(2),
    En => S
        );
        
TS_2 : Tri_State
port map( 
    I => A(1),
    O => Q(1),
    En => S
        );
        
TS_3 : Tri_State
port map( 
    I => A(0),
    O => Q(0),
    En => S
        );

TS_4 : Tri_State
port map( 
    I => B(3),
    O => Q(3),
    En => Not_S
        );
                
TS_5 : Tri_State
port map( 
    I => B(2),
    O => Q(2),
    En => Not_S
        );
        
TS_6 : Tri_State
port map( 
    I => B(1),
    O => Q(1),
    En => Not_S
        );
        
TS_7 : Tri_State
port map( 
    I => B(0),
    O => Q(0),
    En => Not_S
        );
        
end Behavioral;
