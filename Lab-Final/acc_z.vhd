library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity acc_z is
  Port ( clk    : in  STD_LOGIC;
         reset  : in  STD_LOGIC;
         acc_en : in  STD_LOGIC;
         z_en   : in  STD_LOGIC;
         d      : in  STD_LOGIC_VECTOR(7 downto 0);
         q      : out STD_LOGIC_VECTOR(7 downto 0);
         z      : out STD_LOGIC);
end acc_z;

architecture Behavioral of acc_z is
  signal acc_r : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
  signal z_r   : STD_LOGIC := '1';
begin
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        acc_r <= (others => '0');
        z_r   <= '1';
      else
        if acc_en = '1' then acc_r <= d; end if;
        if z_en = '1' then
          if d = "00000000" then z_r <= '1'; else z_r <= '0'; end if;
        end if;
      end if;
    end if;
  end process;
  q <= acc_r;
  z <= z_r;
end Behavioral;
