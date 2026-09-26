library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NAND_GATE is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end NAND_GATE;

architecture Behavioral of NAND_GATE is

begin

    Y <= A NAND B;

end Behavioral;