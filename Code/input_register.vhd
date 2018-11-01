LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY InputReg IS
	GENERIC (N : INTEGER := 16);
	PORT (
		A_IN, B_IN : IN std_logic_vector(N - 1 DOWNTO 0); 
		CTRL_IN : IN std_logic_vector(3 DOWNTO 0); 
		A_OUT, B_OUT : OUT std_logic_vector(N - 1 DOWNTO 0); 
		CTRL_OUT : OUT std_logic_vector(3 DOWNTO 0); 
		clk, RESET : IN std_logic
	);

END InputReg;

ARCHITECTURE Behavioural OF InputReg IS
BEGIN
	PROCESS (clk, RESET)
	BEGIN
		-- asynchronous reset (active high)
		IF RESET = '1' THEN
			A_OUT <= (OTHERS => '0');
			B_OUT <= (OTHERS => '0');
			CTRL_OUT <= (OTHERS => '0'); --reset to ADD operation

		ELSIF (rising_edge(clk)) THEN
			A_OUT <= A_IN;
			B_OUT <= B_IN;
			CTRL_OUT <= CTRL_IN;
		END IF;
 
	END PROCESS;
 
END Behavioural;
