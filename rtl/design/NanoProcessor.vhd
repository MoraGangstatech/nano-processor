----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2024 08:31:32 PM
-- Design Name: 
-- Module Name: NanoProcessor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY NanoProcessor IS
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        Seven_Seg_Out : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        LED_Out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Anode: out STD_LOGIC_VECTOR(3 downto 0));
END NanoProcessor;

ARCHITECTURE Behavioral OF NanoProcessor IS

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

    COMPONENT PC
        PORT (
            Reset : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            D : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Memory_select : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    COMPONENT Program_ROM
        PORT (
            MemoryAddress : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
    END COMPONENT;

    COMPONENT Adder_3bit
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            B : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
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

    COMPONENT Adder_Subtractor_4bit
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            M : IN STD_LOGIC;--IF M=0 => Addition; IF M=1 => Subtraction;
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            C_out : OUT STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT MUX_2_3bit
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            S : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
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
            out7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT LUT_7_Segment
        PORT (
            address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            data : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;

    SIGNAL PC_Mux_Out, Memory_select, PC_Adder_Out, Jump_Addr : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL Reg_En, Reg_Sel_0, Reg_Sel_1 : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL Value, Load_Mux_Out, Mux_0_Out, Mux_1_Out, Adder_Sub_Out : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL R0, R1, R2, R3, R4, R5, R6, R7 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL Instruction : STD_LOGIC_VECTOR (11 DOWNTO 0);
    SIGNAL Jump_Reg, Load_Sel, Add_Sub, Jump_Flag, Zero_Flag : STD_LOGIC;

BEGIN

    Adder_PC : Adder_3bit
    PORT MAP(
        A => Memory_select,
        B => '1',
        S => PC_Adder_Out);

    PC_Mux : MUX_2_3bit
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
        Jump_Reg => Zero_Flag,
        Reg_En => Reg_En,
        Reg_Sel_0 => Reg_Sel_0,
        Value => Value,
        Load_Sel => Load_Sel,
        Reg_Sel_1 => Reg_Sel_1,
        Add_Sub => Add_Sub,
        Jump_Flag => Jump_Flag,
        Jump_Addr => Jump_Addr);

    Register_Bank : Reg_bank
    PORT MAP(
        clk => Clk,
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
        out7 => R7);

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

    Adder_Sub : Adder_Subtractor_4bit
    PORT MAP(
        A => Mux_1_Out,
        B => Mux_0_Out, -- for NEG command
        M => Add_Sub, --IF M=0 => Addition; IF M=1 => Subtraction;
        S => Adder_Sub_Out,
        Overflow => Overflow,
        Zero => Zero_Flag);

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
        Clk => Clk,
        Memory_select => Memory_select,
        D => PC_Mux_Out);

    Zero <= Zero_Flag;
    LED_Out <= R7;
    Anode <= "1110";

END Behavioral;