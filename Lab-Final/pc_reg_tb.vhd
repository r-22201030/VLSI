library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_reg_tb is
end pc_reg_tb;

architecture behavior of pc_reg_tb is
  component pc_reg is
    Port ( clk, reset, load : in STD_LOGIC;
           target : in STD_LOGIC_VECTOR(3 downto 0);
           pc_out : out STD_LOGIC_VECTOR(3 downto 0));
  end component;
  signal clk, reset, load : STD_LOGIC := '0';
  signal target, pc_out : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
begin
  uut: pc_reg port map (clk, reset, load, target, pc_out);

  clk_proc: process
  begin
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;
  end process;

  stim: process
  begin
    reset <= '1'; wait for 10 ns;        -- reset at first rising edge (5 ns)
    reset <= '0'; wait for 30 ns;        -- count up 1,2,3
    target <= "0101"; load <= '1'; wait for 10 ns;  -- jump to 5
    load <= '0'; wait for 30 ns;         -- count up from 5
    reset <= '1'; wait for 10 ns;        -- reset again
    reset <= '0'; wait for 20 ns;
    wait;
  end process;
end behavior;
