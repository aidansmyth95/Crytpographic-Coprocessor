LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

ENTITY TestProgram IS
    generic (N: integer := 16);
END TestProgram;

ARCHITECTURE Test OF TestProgram IS

Component COPROC
  PORT(
       -- Outputs
        CLK,RESET: in STD_LOGIC;
	    RegA   : in STD_LOGIC_vector(3 downto 0);
	    RegB   : in STD_LOGIC_vector(3 downto 0);
       	CTRL   	: in STD_LOGIC_vector(3 downto 0);
	   	RegR : in STD_LOGIC_vector(3 downto 0)      );
END COMPONENT;

    --Input file
    file test_prog : text;

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal CTRL : std_logic_vector(3 downto 0) := (others => '0');
   signal RegA : std_logic_vector(3 downto 0) := (others => '0');
   signal RegB : std_logic_vector(3 downto 0) := (others => '0');
   signal RegR : std_logic_vector(3 downto 0) := (others => '0');

     -- Clock period definitions
   constant clk_period : time := 20 ns;

BEGIN
  
  coprocessor: coproc port map(
    clk => clk, reset => reset, RegA => RegA, RegB => RegB,
    ctrl => ctrl, regR => regR  );
  
  
-- CLOCK GENERATOR  
  CLK_PROC: process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;   
  end process;  

 stim_proc: process

 variable v_ILINE     : line;
 variable v_instr : std_logic_vector(N-1 downto 0);
 
 begin
  file_open(test_prog, "C:/Users/Public/test_prog.txt",  read_mode);

  -- hold reset state for 100 ns.
  reset <= '1';
  RegA <= "0000";
  RegB <= "0000";
  RegR <= "0000";
  CTRL <= "0111";
  wait for 100 ns; 
  reset <= '0';
  
 for i in 1 to 10 loop
    -- Read instruction word
    readline(test_prog, v_ILINE);
    read(v_ILINE, v_instr);
    -- Assign to registers
    RegA <= v_instr(11 downto 8);
    RegB <= v_instr(7 downto 4);
    RegR <= v_instr(3 downto 0);
    CTRL <= v_instr(15 downto 12); 
       
    wait for clk_period;
 end loop;
     
  file_close(test_prog);
   
  wait;
  end process;     

END Test;
