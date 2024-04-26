-- vhdl-linter-disable unused
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_ID IS
  --  Port ( );
END TB_ID;

ARCHITECTURE Behavioral OF TB_ID IS

  COMPONENT Instruction_Decoder
    PORT (
      Instruction : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
      ALU_A : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
      ALU_B : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
      Im_Val : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      Jump_Flag : OUT STD_LOGIC;
      Jump_Addr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      ALU_Control : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
      Reg_En : OUT STD_LOGIC;
      Reg_Addr : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
      Zero_Flag : IN STD_LOGIC;
      Sign_Flag : IN STD_LOGIC;
      Load_Sel : OUT STD_LOGIC);
  END COMPONENT;

  SIGNAL Jump_Addr, Reg_Sel_1, Reg_Sel_0, Reg_En : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL Im_Val : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL Instruction : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL Load_Sel, Jump_Flag, Zero_Flag, Sign_Flag : STD_LOGIC;
  SIGNAL ALU_A, ALU_B, ALU_Control, Reg_Addr : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN

  UUT : Instruction_Decoder PORT MAP(
    Instruction => Instruction,
    ALU_A => ALU_A,
    ALU_B => ALU_B,
    Im_Val => Im_Val,
    Jump_Flag => Jump_Flag,
    Jump_Addr => Jump_Addr,
    ALU_Control => ALU_Control,
    Reg_En => Reg_En,
    Reg_Addr => Reg_Addr,
    Zero_Flag => Zero_Flag,
    Sign_Flag => Sign_Flag,
    Load_Sel => Load_Sel
  );

  PROCESS
  BEGIN

    Zero_Flag <= '0';
    Sign_Flag <= '0';
    Instruction <= "100010001010";
    WAIT FOR 100 ns; -- after 100 ns change inputs

    Instruction <= "100100000001";
    WAIT FOR 100 ns; -- after 100 ns change inputs

    Instruction <= "010100000000";
    WAIT FOR 100 ns; -- after 100 ns change inputs

    Instruction <= "000010100000";
    WAIT FOR 100 ns; -- after 100 ns change inputs

    Instruction <= "110000000000";
    WAIT FOR 100 ns; -- after 100 ns change inputs

    WAIT; -- will wait forever

  END PROCESS;

END Behavioral;