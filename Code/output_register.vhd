LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY OutputReg IS
	GENERIC (N : INTEGER := 16);
	PORT (
		RES_IN : IN std_logic_vector(N - 1 DOWNTO 0); 
		RES_OUT : OUT std_logic_vector(N - 1 DOWNTO 0); 
	clk, RESET : IN std_logic); -- clock and reset

END OutputReg;

ARCHITECTURE Behavioural OF OutputReg IS
BEGIN
	PROCESS (clk, RESET)
	BEGIN
		-- asynchronous reset (active high)
		IF RESET = '1' THEN
			RES_OUT <= (OTHERS => '0');

		ELSIF (falling_edge(clk)) THEN
			RES_OUT <= RES_IN;
		END IF;
 
	END PROCESS;
 
END Behavioural;
