LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Instruction_Decoder IS
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
END Instruction_Decoder;

ARCHITECTURE Behavioral OF Instruction_Decoder IS

    SIGNAL Immediate : STD_LOGIC;

BEGIN

    ALU_Control <= Instruction(12 DOWNTO 10);

    ALU_A <= Instruction(9 DOWNTO 7);
    ALU_B <= Instruction(6 DOWNTO 4);

    Jump_Addr <= Instruction(3 DOWNTO 0);

    Jump_Flag <= (Instruction(13) AND Instruction(11) AND (NOT Instruction(10)) AND Zero_Flag)
        OR (Instruction(13) AND Instruction(10) AND (NOT Instruction(11)) AND (NOT Zero_Flag))
        OR (Instruction(13) AND Instruction(12) AND Instruction(11) AND (NOT Instruction(10)) AND Sign_Flag);
    Reg_En <= (NOT Instruction(13)) OR Immediate;

    Im_Val <= Instruction(3 DOWNTO 0);

    Immediate <= (Instruction(13) AND Instruction(12) AND (Instruction(10)) AND Instruction(11)); -- 1 when move opcode

    Reg_Addr <= Instruction(9 DOWNTO 7);

    Load_Sel <= Immediate;

END Behavioral;