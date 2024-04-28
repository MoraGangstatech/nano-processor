LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY NanoProcessor IS
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        Seven_Seg_Out : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        LED_Out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Anode : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END NanoProcessor;

ARCHITECTURE Behavioral OF NanoProcessor IS

    COMPONENT Slow_Clk
        PORT (
            Clk_in : IN STD_LOGIC;
            Clk_out : OUT STD_LOGIC);
    END COMPONENT;

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

    COMPONENT PC
        PORT (
            Reset : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Memory_select : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT Program_ROM
        PORT (
            MemoryAddress : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR (13 DOWNTO 0));
    END COMPONENT;

    COMPONENT Adder_4bit
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            C_out : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT Mux_8_4bit
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
    END COMPONENT;

    COMPONENT ALU
        PORT (
            Control : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC;
            Carry : OUT STD_LOGIC;
            Sign : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT MUX_2_4bit
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            S : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT Reg_bank
        PORT (
            clk : IN STD_LOGIC;
            Reg_en : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            res : IN STD_LOGIC;
            out0 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out3 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out4 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out5 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            out6 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Bank_En : IN STD_LOGIC;
            out7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT LUT_7_Segment
        PORT (
            address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            data : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;

    SIGNAL PC_Mux_Out, Memory_select, PC_Adder_Out, Jump_Addr : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL Reg_En, Reg_Sel_0, Reg_Sel_1 : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL ACL_CTRL : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL Value, Load_Mux_Out, Mux_0_Out, Mux_1_Out, Adder_Sub_Out : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R0, R1, R2, R3, R4, R5, R6, R7 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL Instruction : STD_LOGIC_VECTOR (13 DOWNTO 0);
    SIGNAL Load_Sel, Sign_Flag, Jump_Flag, Zero_Flag, Slow_Clk_Out, Bank_En : STD_LOGIC;

BEGIN

    Slow_Clock : Slow_Clk
    PORT MAP(
        Clk_in => Clk,
        Clk_out => Slow_Clk_Out);

    Adder_PC : Adder_4bit
    PORT MAP(
        A => Memory_select,
        B => '1',
        S => PC_Adder_Out);

    PC_Mux : MUX_2_4bit
    PORT MAP(
        A => Jump_Addr,
        B => PC_Adder_Out,
        S => Jump_Flag,
        Q => PC_Mux_Out);

    ROM : Program_ROM
    PORT MAP(
        MemoryAddress => Memory_select,
        Instruction => Instruction);

    ID : Instruction_Decoder
    PORT MAP(
        Instruction => Instruction,
        Zero_Flag => Zero_Flag,
        Reg_En => Bank_En,
        Reg_Addr => Reg_En,
        ALU_A => Reg_Sel_0,
        Im_Val => Value,
        Load_Sel => Load_Sel,
        ALU_B => Reg_Sel_1,
        ALU_Control => ACL_CTRL,
        Jump_Flag => Jump_Flag,
        Jump_Addr => Jump_Addr,
        Sign_Flag => Sign_Flag);

    Register_Bank : Reg_bank
    PORT MAP(
        clk => Slow_Clk_Out,
        Reg_en => Reg_En,
        data => Load_Mux_Out,
        res => Reset,
        out0 => R0,
        out1 => R1,
        out2 => R2,
        out3 => R3,
        out4 => R4,
        out5 => R5,
        out6 => R6,
        out7 => R7,
        Bank_En => Bank_En);

    Mux_0 : Mux_8_4bit
    PORT MAP(
        Reg_Sel => Reg_Sel_0,
        R0 => R0,
        R1 => R1,
        R2 => R2,
        R3 => R3,
        R4 => R4,
        R5 => R5,
        R6 => R6,
        R7 => R7,
        Output => Mux_0_Out);

    Mux_1 : Mux_8_4bit
    PORT MAP(
        Reg_Sel => Reg_Sel_1,
        R0 => R0,
        R1 => R1,
        R2 => R2,
        R3 => R3,
        R4 => R4,
        R5 => R5,
        R6 => R6,
        R7 => R7,
        Output => Mux_1_Out);

    Adder_Sub : ALU
    PORT MAP(
        A => Mux_0_Out,
        B => Mux_1_Out, -- for NEG command
        Control => ACL_CTRL, --IF M=0 => Addition; IF M=1 => Subtraction;
        S => Adder_Sub_Out,
        Overflow => Overflow,
        Zero => Zero_Flag,
        Sign => Sign_Flag);

    Load_Mux : MUX_2_4bit
    PORT MAP(
        A => Value,
        B => Adder_Sub_Out,
        S => Load_Sel,
        Q => Load_Mux_Out);

    LUT_7 : LUT_7_Segment
    PORT MAP(
        address => R7,
        data => Seven_Seg_Out);

    Program_C : PC
    PORT MAP(
        Reset => Reset,
        Clk => Slow_Clk_Out,
        Memory_select => Memory_select,
        D => PC_Mux_Out);

    Zero <= Zero_Flag;
    LED_Out <= R7;
    Anode <= "1110";

END Behavioral;