library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity prog_rom is
  Port ( addr  : in  STD_LOGIC_VECTOR(3 downto 0);
         instr : out STD_LOGIC_VECTOR(11 downto 0));
end prog_rom;

architecture Behavioral of prog_rom is
  type rom_t is array (0 to 15) of STD_LOGIC_VECTOR(11 downto 0);
  constant ROM : rom_t := (
    0 => x"1A5",  -- LDI 0xA5
    1 => x"45A",  -- AND 0x5A
    2 => x"C05",  -- JZ 0x05
    3 => x"201",  -- ADD 0x01
    4 => x"201",  -- ADD 0x01
    5 => x"700",  -- NOT
    6 => x"40F",  -- AND 0x0F
    7 => x"C00",  -- JZ 0x00
    8 => x"201",  -- ADD 0x01
    others => x"000");
begin
  instr <= ROM(to_integer(unsigned(addr)));
end Behavioral;
