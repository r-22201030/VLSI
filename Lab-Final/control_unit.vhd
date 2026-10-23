library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
  Port ( opcode  : in  STD_LOGIC_VECTOR(3 downto 0);
         z       : in  STD_LOGIC;
         alu_sel : out STD_LOGIC_VECTOR(1 downto 0);
         acc_en  : out STD_LOGIC;
         z_en    : out STD_LOGIC;
         pc_load : out STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is
begin
  process(opcode, z)
  begin
    alu_sel <= "00"; acc_en <= '0'; z_en <= '0'; pc_load <= '0';
    case opcode is
      when "0001" => alu_sel <= "00"; acc_en <= '1'; z_en <= '1'; -- LDI
      when "0010" => alu_sel <= "01"; acc_en <= '1'; z_en <= '1'; -- ADD
      when "0100" => alu_sel <= "10"; acc_en <= '1'; z_en <= '1'; -- AND
      when "0111" => alu_sel <= "11"; acc_en <= '1'; z_en <= '1'; -- NOT
      when "1100" => pc_load <= z;                                -- JZ
      when others => null;                                        -- NOP
    end case;
  end process;
end Behavioral;
