LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder_3bit IS
     PORT (
          A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
          B : IN STD_LOGIC;
          S : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
          C_out : OUT STD_LOGIC);
END Adder_3bit;

ARCHITECTURE Behavioral OF Adder_3bit IS

     COMPONENT HA
          PORT (
               A : IN STD_LOGIC;
               B : IN STD_LOGIC;
               S : OUT STD_LOGIC;
               C : OUT STD_LOGIC);
     END COMPONENT;
     SIGNAL HA0_C, HA1_C : STD_LOGIC;

BEGIN

     HA_0 : HA
     PORT MAP(
          A => A(0),
          B => B,
          S => S(0),
          C => HA0_C);

     HA_1 : HA
     PORT MAP(
          A => A(1),
          B => HA0_C,
          S => S(1),
          C => HA1_C);

     HA_2 : HA
     PORT MAP(
          A => A(2),
          B => HA1_C,
          S => S(2),
          C => C_out);

END Behavioral;