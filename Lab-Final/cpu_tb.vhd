library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_tb is
end cpu_tb;

architecture behavior of cpu_tb is
  component cpu_top is
    Port ( CLK, RESET : in STD_LOGIC;
           Q  : out STD_LOGIC_VECTOR(7 downto 0);
           Z  : out STD_LOGIC;
           PC : out STD_LOGIC_VECTOR(3 downto 0));
  end component;
  signal CLK   : STD_LOGIC := '0';
  signal RESET : STD_LOGIC := '1';
  signal Q  : STD_LOGIC_VECTOR(7 downto 0);
  signal Z  : STD_LOGIC;
  signal PC : STD_LOGIC_VECTOR(3 downto 0);
begin
  uut: cpu_top port map (CLK, RESET, Q, Z, PC);

  clk_proc: process
  begin
    CLK <= '0'; wait for 5 ns;
    CLK <= '1'; wait for 5 ns;
  end process;

  stim_proc: process
  begin
    RESET <= '1';
    wait for 7 ns;
    RESET <= '0';
    wait for 70 ns;
    wait;
  end process;
end behavior;
