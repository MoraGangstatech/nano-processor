library ieee;
use ieee.std_logic_1164.all;

entity Tri_State_3bit is
    port (
        En : in std_logic;
        I : in STD_LOGIC_VECTOR (2 downto 0);
        O : out STD_LOGIC_VECTOR (2 downto 0)
    );
end entity Tri_State_3bit;

architecture Behavioral of Tri_State_3bit is
begin
    process (En,I)
    begin
        if En = '1' then
            O <= I;
        else
            O <= "ZZZ";  -- High impedance state
        end if;
    end process;
end architecture Behavioral;
