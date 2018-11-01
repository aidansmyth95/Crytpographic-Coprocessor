library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity coproc is
generic (N: integer := 16);
    Port ( 
           clk,reset : in STD_LOGIC;
           CTRL : in STD_LOGIC_VECTOR (3 downto 0);
           RegA,RegB,RegR : in STD_LOGIC_VECTOR (3 downto 0)
           );
end coproc;

Architecture Behavioral of coproc is

--internal signals
signal sig_inreg_A_out,sig_inreg_B_out,sig_outreg_RESULT_in: STD_LOGIC_VECTOR (N-1 downto 0);
signal RegR_tmp,CTRL_tmp: std_logic_vector(3 downto 0);
signal write_en: std_logic;
 
-- Component Declarations
component Structural is
        Port ( 
           A_BUS,B_BUS : in STD_LOGIC_VECTOR (N-1 downto 0);
           CTRL:   in STD_LOGIC_VECTOR (3 downto 0);
           RESULT : out STD_LOGIC_VECTOR (N-1 downto 0));
end component;

component register_file is
port ( 
    clk,RESET,En: in std_logic; 
    RES : in std_logic_vector(N-1 downto 0); 
    RegA,RegB,RegR: in std_logic_vector(3 downto 0); -- selected registers
    ReadA,ReadB: out std_logic_vector(N-1 downto 0));
end component register_file;

begin

LOGIC_STRUCT: Structural port map(
       A_BUS=>sig_inreg_A_out,
       B_BUS=>sig_inreg_B_out,
       CTRL=>CTRL_tmp,
       RESULT=>sig_outreg_RESULT_in);
   
Register_file_16x16: register_file port map( 
                   clk=> clk, 
                   reset => reset,
                   En => Write_En, 
                   RES => sig_outreg_RESULT_in, 
                   RegA => RegA, 
                   RegB => RegB, 
                   RegR => RegR_tmp,
                   ReadA => sig_inreg_A_out, 
                   ReadB => sig_inreg_B_out);

       --- input register VHDL
       process(clk,reset) 
       begin
            if(rising_edge(clk)) then
                if(reset = '1') then
                    CTRL_tmp <= x"0";
                    RegR_tmp <= x"0";
                else
                    RegR_tmp <= RegR;          -- Handles flaw
                    CTRL_tmp <= CTRL;
                        if(CTRL = "0111") then -- NOP Instruction
                            Write_En <= '0';
                        else
                            Write_En <= '1';   
                        end if;
                end if;
            end if;
       end process;   
          
end Behavioral;
