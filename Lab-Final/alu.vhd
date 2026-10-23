library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
  Port ( a   : in  STD_LOGIC_VECTOR(7 downto 0);
         b   : in  STD_LOGIC_VECTOR(7 downto 0);
         sel : in  STD_LOGIC_VECTOR(1 downto 0);
         res : out STD_LOGIC_VECTOR(7 downto 0));
end alu;

architecture Behavioral of alu is
begin
  process(a, b, sel)
  begin
    case sel is
      when "00"   => res <= b;                                           -- LDI
      when "01"   => res <= std_logic_vector(unsigned(a) + unsigned(b)); -- ADD
      when "10"   => res <= a and b;                                     -- AND
      when others => res <= not a;                                       -- NOT
    end case;
  end process;
end Behavioral;
