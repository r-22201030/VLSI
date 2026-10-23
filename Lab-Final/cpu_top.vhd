library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
  Port ( CLK   : in  STD_LOGIC;
         RESET : in  STD_LOGIC;
         Q     : out STD_LOGIC_VECTOR(7 downto 0);
         Z     : out STD_LOGIC;
         PC    : out STD_LOGIC_VECTOR(3 downto 0));
end cpu_top;

architecture Structural of cpu_top is
  component alu is
    Port ( a, b : in STD_LOGIC_VECTOR(7 downto 0);
           sel  : in STD_LOGIC_VECTOR(1 downto 0);
           res  : out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  component prog_rom is
    Port ( addr  : in STD_LOGIC_VECTOR(3 downto 0);
           instr : out STD_LOGIC_VECTOR(11 downto 0));
  end component;
  component pc_reg is
    Port ( clk, reset, load : in STD_LOGIC;
           target : in STD_LOGIC_VECTOR(3 downto 0);
           pc_out : out STD_LOGIC_VECTOR(3 downto 0));
  end component;
  component control_unit is
    Port ( opcode  : in STD_LOGIC_VECTOR(3 downto 0);
           z       : in STD_LOGIC;
           alu_sel : out STD_LOGIC_VECTOR(1 downto 0);
           acc_en, z_en, pc_load : out STD_LOGIC);
  end component;
  component acc_z is
    Port ( clk, reset, acc_en, z_en : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR(7 downto 0);
           q : out STD_LOGIC_VECTOR(7 downto 0);
           z : out STD_LOGIC);
  end component;

  signal pc_s    : STD_LOGIC_VECTOR(3 downto 0);
  signal instr_s : STD_LOGIC_VECTOR(11 downto 0);
  signal sel_s   : STD_LOGIC_VECTOR(1 downto 0);
  signal acc_en_s, z_en_s, load_s, z_s : STD_LOGIC;
  signal acc_s, res_s : STD_LOGIC_VECTOR(7 downto 0);
begin
  U_PC  : pc_reg port map (CLK, RESET, load_s, instr_s(3 downto 0), pc_s);
  U_ROM : prog_rom port map (pc_s, instr_s);
  U_CU  : control_unit port map (instr_s(11 downto 8), z_s, sel_s, acc_en_s, z_en_s, load_s);
  U_ALU : alu port map (acc_s, instr_s(7 downto 0), sel_s, res_s);
  U_REG : acc_z port map (CLK, RESET, acc_en_s, z_en_s, res_s, acc_s, z_s);

  Q  <= acc_s;
  Z  <= z_s;
  PC <= pc_s;
end Structural;
