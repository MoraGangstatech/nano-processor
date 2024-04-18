LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MUX_2_4bit IS
      PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            S : IN STD_LOGIC; -- 1 A
            Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END MUX_2_4bit;

ARCHITECTURE Behavioral OF MUX_2_4bit IS

      COMPONENT Tri_State_4bit
            PORT (
                  En : IN STD_LOGIC;
                  I : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                  O : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
            );
      END COMPONENT;

      SIGNAL Not_S : STD_LOGIC;

BEGIN

      Not_S <= NOT S;

      Tri_State_Buffer_A : Tri_State_4bit
      PORT MAP(
            En => S,
            I => A,
            O => Q);

      Tri_State_Buffer_B : Tri_State_4bit
      PORT MAP(
            En => Not_S,
            I => B,
            O => Q);

END Behavioral;