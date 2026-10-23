library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity prog_rom_tb is
end prog_rom_tb;

architecture behavior of prog_rom_tb is
  component prog_rom is
    Port ( addr  : in STD_LOGIC_VECTOR(3 downto 0);
           instr : out STD_LOGIC_VECTOR(11 downto 0));
  end component;
  signal addr  : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
  signal instr : STD_LOGIC_VECTOR(11 downto 0);
begin
  uut: prog_rom port map (addr, instr);

  stim: process
  begin
    for i in 0 to 15 loop
      addr <= std_logic_vector(to_unsigned(i, 4));
      wait for 10 ns;
    end loop;
    wait;
  end process;
end behavior;
