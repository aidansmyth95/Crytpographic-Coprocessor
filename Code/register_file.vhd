library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity register_file is
generic (N: integer := 16);

port ( 
   clk,RESET,En: in std_logic; 
   RES: in std_logic_vector(N-1 downto 0); 
   RegA,RegB,RegR: in std_logic_vector(3 downto 0); -- selected registers
   ReadA,ReadB: out std_logic_vector(N-1 downto 0));
end register_file;

architecture Behavioral of register_file is
    
type memory is array(0 to N-1) of std_logic_vector(N-1 downto 0);
signal reg_file: memory :=( -- memory array
  0 => x"0001",
  1 => x"c505",
  2 => x"3c07",
  3 => x"4d05",
  4 => x"1186",
  5 => x"f407",
  6 => x"1086",
  7 => x"4706",
  8 => x"6808",
  9 => x"baa0",
  10 => x"c902",
  11 => x"100b",
  12 => x"c000",
  13 => x"c902",
  14 => x"100b",
  15 => x"B000",
  others => (others => '0')
  );
  
begin

-- Synchronous Write Operation
reg_write: process(clk) 
begin
if(rising_edge(clk)) then
-- Read and reset functions
    if(RESET = '1') then
        ReadA <= x"0000";
        ReadB <= x"0000";
    else
        ReadA <= reg_file(to_integer(unsigned(RegA)));
        ReadB <= reg_file(to_integer(unsigned(RegB)));
    end if;
    
-- Write functions
    if(En = '1') then         -- write high
        reg_file(to_integer(unsigned(RegR))) <= RES;
        
        if (RegA = RegR) then  -- Bypass for read A
            ReadA <= RES;
        end if; 
        
        if (RegB = RegR) then  -- Bypass for read B
            ReadB <= RES;
        end if;     
    end if;
    
end if;

end process;



end Behavioral;