LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux_8_4bit IS
       PORT (
              Reg_Sel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
              R0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
              R1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
              R2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
              R3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
              R4 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
              R5 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
              R6 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
              R7 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
              Output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Mux_8_4bit;

ARCHITECTURE Behavioral OF Mux_8_4bit IS

       COMPONENT Decoder_3_to_8
              PORT (
                     I : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                     Y : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
       END COMPONENT;

       COMPONENT Tri_State_4bit
              PORT (
                     I : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                     En : IN STD_LOGIC;
                     O : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
       END COMPONENT;

       SIGNAL Reg_enables : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN

       Decoder_3_to_8_0 : Decoder_3_to_8
       PORT MAP(
              I => Reg_Sel,
              Y => Reg_enables);

       Tri_State_4bit_0 : Tri_State_4bit
       PORT MAP(
              I => R0,
              En => Reg_enables(0),
              O => Output);

       Tri_State_4bit_1 : Tri_State_4bit
       PORT MAP(
              I => R1,
              En => Reg_enables(1),
              O => Output);

       Tri_State_4bit_2 : Tri_State_4bit
       PORT MAP(
              I => R2,
              En => Reg_enables(2),
              O => Output);

       Tri_State_4bit_3 : Tri_State_4bit
       PORT MAP(
              I => R3,
              En => Reg_enables(3),
              O => Output);

       Tri_State_4bit_4 : Tri_State_4bit
       PORT MAP(
              I => R4,
              En => Reg_enables(4),
              O => Output);

       Tri_State_4bit_5 : Tri_State_4bit
       PORT MAP(
              I => R5,
              En => Reg_enables(5),
              O => Output);

       Tri_State_4bit_6 : Tri_State_4bit
       PORT MAP(
              I => R6,
              En => Reg_enables(6),
              O => Output);

       Tri_State_4bit_7 : Tri_State_4bit
       PORT MAP(
              I => R7,
              En => Reg_enables(7),
              O => Output);

END Behavioral;