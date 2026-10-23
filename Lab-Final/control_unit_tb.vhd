library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit_tb is
end control_unit_tb;

architecture behavior of control_unit_tb is
  component control_unit is
    Port ( opcode  : in STD_LOGIC_VECTOR(3 downto 0);
           z       : in STD_LOGIC;
           alu_sel : out STD_LOGIC_VECTOR(1 downto 0);
           acc_en, z_en, pc_load : out STD_LOGIC);
  end component;
  signal opcode : STD_LOGIC_VECTOR(3 downto 0) := "0000";
  signal z : STD_LOGIC := '0';
  signal alu_sel : STD_LOGIC_VECTOR(1 downto 0);
  signal acc_en, z_en, pc_load : STD_LOGIC;
begin
  uut: control_unit port map (opcode, z, alu_sel, acc_en, z_en, pc_load);

  stim: process
  begin
    opcode <= "0001"; z <= '0'; wait for 10 ns;   -- LDI
    assert alu_sel = "00" and acc_en = '1' and z_en = '1' and pc_load = '0' report "LDI ctrl" severity error;
    opcode <= "0010"; wait for 10 ns;             -- ADD
    assert alu_sel = "01" and acc_en = '1' and z_en = '1' and pc_load = '0' report "ADD ctrl" severity error;
    opcode <= "0100"; wait for 10 ns;             -- AND
    assert alu_sel = "10" and acc_en = '1' and z_en = '1' and pc_load = '0' report "AND ctrl" severity error;
    opcode <= "0111"; wait for 10 ns;             -- NOT
    assert alu_sel = "11" and acc_en = '1' and z_en = '1' and pc_load = '0' report "NOT ctrl" severity error;
    opcode <= "1100"; z <= '0'; wait for 10 ns;   -- JZ not taken
    assert acc_en = '0' and z_en = '0' and pc_load = '0' report "JZ(z=0) ctrl" severity error;
    z <= '1'; wait for 10 ns;                     -- JZ taken
    assert acc_en = '0' and z_en = '0' and pc_load = '1' report "JZ(z=1) ctrl" severity error;
    opcode <= "0000"; wait for 10 ns;             -- NOP
    assert acc_en = '0' and z_en = '0' and pc_load = '0' report "NOP ctrl" severity error;
    wait;
  end process;
end behavior;
