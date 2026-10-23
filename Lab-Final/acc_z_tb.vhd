library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_z_tb is
end acc_z_tb;

architecture behavior of acc_z_tb is
  component acc_z is
    Port ( clk, reset, acc_en, z_en : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR(7 downto 0);
           q : out STD_LOGIC_VECTOR(7 downto 0);
           z : out STD_LOGIC);
  end component;
  signal clk, reset, acc_en, z_en : STD_LOGIC := '0';
  signal d, q : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
  signal z : STD_LOGIC;
begin
  uut: acc_z port map (clk, reset, acc_en, z_en, d, q, z);

  clk_proc: process
  begin
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;
  end process;

  stim: process
  begin
    reset <= '1'; wait for 10 ns;                       -- reset: ACC=0, Z=1
    reset <= '0';
    d <= x"A5"; acc_en <= '1'; z_en <= '1'; wait for 10 ns;  -- load 0xA5, Z=0
    d <= x"00"; wait for 10 ns;                         -- load 0x00, Z=1
    d <= x"FF"; acc_en <= '0'; z_en <= '0'; wait for 10 ns;  -- no enable: hold
    d <= x"0F"; acc_en <= '1'; z_en <= '1'; wait for 10 ns;  -- load 0x0F, Z=0
    wait;
  end process;
end behavior;
