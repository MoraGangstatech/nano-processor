LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux_4_1_4bit IS
      PORT (
            I0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            I1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            I2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            I3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            sel : IN STD_LOGIC_VECTOR (1 DOWNTO 0));
END Mux_4_1_4bit;

ARCHITECTURE Behavioral OF Mux_4_1_4bit IS

      COMPONENT MUX_2_4bit
            PORT (
                  A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                  B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                  S : IN STD_LOGIC; -- 1 A
                  Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
      END COMPONENT;

      COMPONENT Tri_State_4bit
            PORT (
                  En : IN STD_LOGIC;
                  I : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                  O : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
            );
      END COMPONENT;

      SIGNAL Sel_1, Not_Sel_1 : STD_LOGIC;
      SIGNAL Q1, Q0 : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

      Sel_1 <= Sel(1);
      Not_Sel_1 <= NOT Sel(1);

      Mux_0 : MUX_2_4bit
      PORT MAP(
            A => I1,
            B => I0,
            S => Sel(0),
            Q => Q0);

      Mux_1 : MUX_2_4bit
      PORT MAP(
            A => I3,
            B => I2,
            S => Sel(0),
            Q => Q1);

      Tri_State_Buffer_0 : Tri_State_4bit
      PORT MAP(
            En => Not_Sel_1,
            I => Q0,
            O => Output);

      Tri_State_Buffer_1 : Tri_State_4bit
      PORT MAP(
            En => Sel_1,
            I => Q1,
            O => Output);

END Behavioral;