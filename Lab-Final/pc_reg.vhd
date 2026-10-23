library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pc_reg is
  Port ( clk    : in  STD_LOGIC;
         reset  : in  STD_LOGIC;
         load   : in  STD_LOGIC;
         target : in  STD_LOGIC_VECTOR(3 downto 0);
         pc_out : out STD_LOGIC_VECTOR(3 downto 0));
end pc_reg;

architecture Behavioral of pc_reg is
  signal cnt : unsigned(3 downto 0) := (others => '0');
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        cnt <= (others => '0');
      elsif load = '1' then
        cnt <= unsigned(target);
      else
        cnt <= cnt + 1;
      end if;
    end if;
  end process;
  pc_out <= std_logic_vector(cnt);
end Behavioral;
