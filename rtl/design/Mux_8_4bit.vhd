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

       COMPONENT Mux_8_to_1
              PORT (
                     S : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
                     D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
                     Y : OUT STD_LOGIC);
       END COMPONENT;

BEGIN
       Mux_8_to_1_0 : Mux_8_to_1
       PORT MAP(
              D(0) => R0(0),
              D(1) => R1(0),
              D(2) => R2(0),
              D(3) => R3(0),
              D(4) => R4(0),
              D(5) => R5(0),
              D(6) => R6(0),
              D(7) => R7(0),
              S => Reg_Sel,
              Y => Output(0));

       Mux_8_to_1_1 : Mux_8_to_1
       PORT MAP(
              D(0) => R0(1),
              D(1) => R1(1),
              D(2) => R2(1),
              D(3) => R3(1),
              D(4) => R4(1),
              D(5) => R5(1),
              D(6) => R6(1),
              D(7) => R7(1),
              S => Reg_Sel,
              Y => Output(1));

       Mux_8_to_1_2 : Mux_8_to_1
       PORT MAP(
              D(0) => R0(2),
              D(1) => R1(2),
              D(2) => R2(2),
              D(3) => R3(2),
              D(4) => R4(2),
              D(5) => R5(2),
              D(6) => R6(2),
              D(7) => R7(2),
              S => Reg_Sel,
              Y => Output(2));

       Mux_8_to_1_3 : Mux_8_to_1
       PORT MAP(
              D(0) => R0(3),
              D(1) => R1(3),
              D(2) => R2(3),
              D(3) => R3(3),
              D(4) => R4(3),
              D(5) => R5(3),
              D(6) => R6(3),
              D(7) => R7(3),
              S => Reg_Sel,
              Y => Output(3));

END Behavioral;