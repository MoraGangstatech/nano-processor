
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Reg_bank IS
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
END Reg_bank;

ARCHITECTURE Behavioral OF Reg_bank IS

      SIGNAL enable : STD_LOGIC_VECTOR(7 DOWNTO 0);

      COMPONENT Decoder_3_to_8
            PORT (
                  I : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
                  Y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
      END COMPONENT;

      COMPONENT Reg
            PORT (
                  D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
                  En : IN STD_LOGIC;
                  Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                  Res : IN STD_LOGIC;
                  Clk : IN STD_LOGIC);

      END COMPONENT;

BEGIN

      Decoder_3_to_8_reg : Decoder_3_to_8
      PORT MAP(
            I => Reg_en,
            Y => enable);
      -- hardcode R0 to 0
      --Reg_0 : Reg
      --port map( D => "0000",
      --          En => enable(0),
      --          Q => out0,
      --          Res =>res,
      --          Clk => clk);
      out0 <= "0000";

      Reg_1 : Reg
      PORT MAP(
            D => data,
            En => enable(1),
            Q => out1,
            Res => res,
            Clk => clk);

      Reg_2 : Reg
      PORT MAP(
            D => data,
            En => enable(2),
            Q => out2,
            Res => res,
            Clk => clk);

      Reg_3 : Reg
      PORT MAP(
            D => data,
            En => enable(3),
            Q => out3,
            Res => res,
            Clk => clk);

      Reg_4 : Reg
      PORT MAP(
            D => data,
            En => enable(4),
            Q => out4,
            Res => res,
            Clk => clk);

      Reg_5 : Reg
      PORT MAP(
            D => data,
            En => enable(5),
            Q => out5,
            Res => res,
            Clk => clk);

      Reg_6 : Reg
      PORT MAP(
            D => data,
            En => enable(6),
            Q => out6,
            Res => res,
            Clk => clk);

      Reg_7 : Reg
      PORT MAP(
            D => data,
            En => enable(7),
            Q => out7,
            Res => res,
            Clk => clk);

END Behavioral;