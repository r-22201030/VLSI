library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_tb is
end alu_tb;

architecture behavior of alu_tb is
  component alu is
    Port ( a, b : in STD_LOGIC_VECTOR(7 downto 0);
           sel  : in STD_LOGIC_VECTOR(1 downto 0);
           res  : out STD_LOGIC_VECTOR(7 downto 0));
  end component;
  signal a, b, res : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
  signal sel : STD_LOGIC_VECTOR(1 downto 0) := "00";
begin
  uut: alu port map (a, b, sel, res);

  stim: process
  begin
    -- LDI: res = b
    a <= x"11"; b <= x"A5"; sel <= "00"; wait for 10 ns;
    assert res = x"A5" report "LDI failed" severity error;
    -- ADD: 0xF0 + 0x20 = 0x10 (carry discarded)
    a <= x"F0"; b <= x"20"; sel <= "01"; wait for 10 ns;
    assert res = x"10" report "ADD failed" severity error;
    -- AND: 0xA5 and 0x5A = 0x00
    a <= x"A5"; b <= x"5A"; sel <= "10"; wait for 10 ns;
    assert res = x"00" report "AND failed" severity error;
    -- AND: 0xFF and 0x0F = 0x0F
    a <= x"FF"; b <= x"0F"; sel <= "10"; wait for 10 ns;
    assert res = x"0F" report "AND2 failed" severity error;
    -- NOT: not 0x00 = 0xFF
    a <= x"00"; b <= x"00"; sel <= "11"; wait for 10 ns;
    assert res = x"FF" report "NOT failed" severity error;
    wait;
  end process;
end behavior;
