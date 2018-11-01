library IEEE;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_arith.all;	

-- Ensure VHDL 2008 is used. Check source file properties tab, and change Type from
-- VHDL to VHDL 2008

entity Shifter is
generic (N: integer := 16);
    Port ( SHIFTCTRL : in STD_LOGIC_VECTOR (3 downto 0);
           SHIFTIN : in STD_LOGIC_VECTOR (N-1 downto 0);
           SHIFTOUT : out STD_LOGIC_VECTOR (N-1 downto 0));
end Shifter;

architecture Behavioral of Shifter is


begin
process(SHIFTIN, SHIFTCTRL)
    begin
    case SHIFTCTRL is
    when "1000" => --ror4
          SHIFTOUT <= SHIFTIN ror 4;
    when "1001" => --rol4
          SHIFTOUT <= SHIFTIN rol 4;
    when "1010" => --sll4
          SHIFTOUT <= SHIFTIN sll 4;
    when "1011" => --slr4
          SHIFTOUT <= SHIFTIN srl 4;
    when others =>    
          SHIFTOUT <= (others => '0');
    end case;
    end process;
end Behavioral;
