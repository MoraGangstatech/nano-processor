LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_ID IS
  --  Port ( );
END TB_ID;

ARCHITECTURE Behavioral OF TB_ID IS

  COMPONENT Instruction_Decoder
    PORT (
      Instruction : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
      Jump_Reg : IN STD_LOGIC;
      Reg_En : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
      Reg_Sel_0 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
      Value : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      Load_Sel : OUT STD_LOGIC;
      Reg_Sel_1 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
      Add_Sub : OUT STD_LOGIC;
      Jump_Flag : OUT STD_LOGIC;
      Jump_Addr : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
  END COMPONENT;

  SIGNAL Jump_Addr, Reg_Sel_1, Reg_Sel_0, Reg_En : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL Value : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL Instruction : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL Jump_Reg, Load_Sel, Add_Sub, Jump_Flag : STD_LOGIC;

BEGIN

  UUT : Instruction_Decoder PORT MAP(
    Instruction => Instruction,
    Jump_Reg => Jump_Reg,
    Reg_En => Reg_En,
    Reg_Sel_0 => Reg_Sel_0,
    Value => Value,
    Load_Sel => Load_Sel,
    Reg_Sel_1 => Reg_Sel_1,
    Add_Sub => Add_Sub,
    Jump_Flag => Jump_Flag,
    Jump_Addr => Jump_Addr
  );

  PROCESS
  BEGIN

    Jump_Reg <= '0';
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