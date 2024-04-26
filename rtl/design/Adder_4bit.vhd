LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder_4bit IS
     PORT (
          A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
          B : IN STD_LOGIC;
          S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
          C_out : OUT STD_LOGIC);
END Adder_4bit;

ARCHITECTURE Behavioral OF Adder_4bit IS

     COMPONENT HA
          PORT (
               A : IN STD_LOGIC;
               B : IN STD_LOGIC;
               S : OUT STD_LOGIC;
               C : OUT STD_LOGIC);
     END COMPONENT;
     SIGNAL HA0_C, HA1_C, HA2_C : STD_LOGIC;

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
          C => HA2_C);

     HA_3 : HA
     PORT MAP(
          A => A(3),
          B => HA2_C,
          S => S(3),
          C => C_out);

END Behavioral;