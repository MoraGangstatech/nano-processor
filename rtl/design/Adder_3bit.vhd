LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder_3bit IS
     PORT (
          A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
          B : IN STD_LOGIC;
          S : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
          Overflow : OUT STD_LOGIC);
END Adder_3bit;

ARCHITECTURE Behavioral OF Adder_3bit IS

     COMPONENT FA
          PORT (
               A : IN STD_LOGIC;
               B : IN STD_LOGIC;
               C_in : IN STD_LOGIC;
               S : OUT STD_LOGIC;
               C_out : OUT STD_LOGIC);
     END COMPONENT;

     SIGNAL FA0_C, FA1_C : STD_LOGIC;

BEGIN

     FA_0 : FA
     PORT MAP(
          A => A(0),
          B => B,
          C_in => '0',
          S => S(0),
          C_out => FA0_C);

     FA_1 : FA
     PORT MAP(
          A => A(1),
          B => '0',
          C_in => FA0_C,
          S => S(1),
          C_out => FA1_C);

     FA_2 : FA
     PORT MAP(
          A => A(2),
          B => '0',
          C_in => FA1_C,
          S => S(2),
          C_out => Overflow);

END Behavioral;