LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FULL_ADDER_8BIT_TB IS
END FULL_ADDER_8BIT_TB;

ARCHITECTURE behavior OF FULL_ADDER_8BIT_TB IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT FULL_ADDER_8BIT
    PORT(
         A    : IN  std_logic_vector(7 downto 0);
         B    : IN  std_logic_vector(7 downto 0);
         Cin  : IN  std_logic;
         Sum  : OUT std_logic_vector(7 downto 0);
         Cout : OUT std_logic
        );
    END COMPONENT;

    -- Inputs
    signal A   : std_logic_vector(7 downto 0) := (others => '0');
    signal B   : std_logic_vector(7 downto 0) := (others => '0');
    signal Cin : std_logic := '0';

    -- Outputs
    signal Sum  : std_logic_vector(7 downto 0);
    signal Cout : std_logic;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: FULL_ADDER_8BIT PORT MAP (
          A    => A,
          B    => B,
          Cin  => Cin,
          Sum  => Sum,
          Cout => Cout
        );

    -- Stimulus process
    stim_proc: process
    begin

        -- Test 1: 0 + 0 + 0
        A <= "00000000";
        B <= "00000000";
        Cin <= '0';
        wait for 100 ns;

        -- Test 2: 5 + 3 = 8
        A <= "00000101";
        B <= "00000011";
        Cin <= '0';
        wait for 100 ns;

        -- Test 3: 15 + 1 = 16
        A <= "00001111";
        B <= "00000001";
        Cin <= '0';
        wait for 100 ns;

        -- Test 4: 100 + 50 = 150
        A <= "01100100";
        B <= "00110010";
        Cin <= '0';
        wait for 100 ns;

        -- Test 5: 255 + 1 = 256
        A <= "11111111";
        B <= "00000001";
        Cin <= '0';
        wait for 100 ns;

        -- Test 6: 255 + 255 = 510
        A <= "11111111";
        B <= "11111111";
        Cin <= '0';
        wait for 100 ns;

        -- Test 7: 10 + 20 + Cin
        A <= "00001010";
        B <= "00010100";
        Cin <= '1';
        wait for 100 ns;
		
        -- Test 8: Maximum values with carry-in
        A <= "11111111";
        B <= "11111111";
        Cin <= '1';
        wait for 100 ns;

        -- Stop simulation
        wait;

    end process;

END behavior;