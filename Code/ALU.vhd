library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
generic (N: integer := 16);
    Port ( 
           CTRL : in STD_LOGIC_VECTOR (3 downto 0);
           A_BUS : in STD_LOGIC_VECTOR (N-1 downto 0);
           B_BUS : in STD_LOGIC_VECTOR (N-1 downto 0);
           ALU_OUT : out STD_LOGIC_VECTOR (N-1 downto 0));
end ALU;

architecture Behavioral of ALU is

        component n_adder_verilog is     
            port(                 
                A_BUS: IN std_logic_vector((N-1) downto 0);
                B_BUS: IN std_logic_vector((N-1) downto 0);
                CIN: IN std_logic;
                SUM: OUT std_logic_vector((N-1) downto 0)
                 );               
        end component;
        
        signal cout_sum,cout_sub: std_logic; 
        signal sum_op,sub_op,and_op,
               or_op,xor_op,not_op,
               mov_op,not_b
               : std_logic_vector(N-1 downto 0);
      
        
begin

add_n_adder_verilog: n_adder_verilog port map(A_BUS=>A_BUS,B_BUS=>B_BUS,CIN=>'0',SUM=>sum_op);
sub_n_adder_verilog: n_adder_verilog port map(A_BUS=>A_BUS,B_BUS=>not_b,CIN=>'1',SUM=>sub_op);

not_b <= not B_BUS;
or_op <= A_BUS or B_BUS;
and_op <= A_BUS and B_BUS;
xor_op <= A_BUS xor B_BUS;
not_op <= not A_BUS ;
mov_op <= A_BUS;

ALU_OUT<=   sum_op when CTRL = "0000" else
            sub_op when CTRL = "0001" else
            and_op when CTRL = "0010" else
            or_op when CTRL = "0011" else
            xor_op when CTRL = "0100" else
            not_op when CTRL = "0101" else
            mov_op when CTRL = "0110" else
            (others => '0');
            
 end Behavioral;           

