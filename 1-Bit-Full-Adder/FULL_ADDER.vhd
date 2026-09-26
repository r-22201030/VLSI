library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FULL_ADDER is
    Port (
        A    : in  STD_LOGIC;
        B    : in  STD_LOGIC;
        Cin  : in  STD_LOGIC;
        Sum  : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end FULL_ADDER;

architecture Structural of FULL_ADDER is

    -- NAND gate component
    component NAND_GATE
        Port (
            A : in STD_LOGIC;
            B : in STD_LOGIC;
            Y : out STD_LOGIC
        );
    end component;

    -- Internal signals
    signal N1, N2, N3 : STD_LOGIC;
    signal X : STD_LOGIC;
    signal N4, N5, N6 : STD_LOGIC;
    signal N7 : STD_LOGIC;

begin

    -- ==================================
    -- First XOR: A XOR B
    -- ==================================

    NAND1: NAND_GATE
        port map (
            A => A,
            B => B,
            Y => N1
        );

    NAND2: NAND_GATE
        port map (
            A => A,
            B => N1,
            Y => N2
        );

    NAND3: NAND_GATE
        port map (
            A => B,
            B => N1,
            Y => N3
        );

    NAND4: NAND_GATE
        port map (
            A => N2,
            B => N3,
            Y => X
        );


    -- ==================================
    -- Second XOR: X XOR Cin = Sum
    -- ==================================

    NAND5: NAND_GATE
        port map (
            A => X,
            B => Cin,
            Y => N4
        );

    NAND6: NAND_GATE
        port map (
            A => X,
            B => N4,
            Y => N5
        );

    NAND7: NAND_GATE
        port map (
            A => Cin,
            B => N4,
            Y => N6
        );

    NAND8: NAND_GATE
        port map (
            A => N5,
            B => N6,
            Y => Sum
        );


    -- ==================================
    -- Carry Output using NAND only
    -- ==================================

    NAND9: NAND_GATE
        port map (
            A => N1,
            B => N4,
            Y => Cout
        );

end Structural;