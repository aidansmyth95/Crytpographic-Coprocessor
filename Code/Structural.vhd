library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Structural is
generic (N: integer := 16);
    Port ( 
           A_BUS : in STD_LOGIC_VECTOR (N-1 downto 0);
           B_BUS : in STD_LOGIC_VECTOR (N-1 downto 0);
           CTRL:   in STD_LOGIC_VECTOR (3 downto 0);
           RESULT : out STD_LOGIC_VECTOR (N-1 downto 0));
end Structural;

architecture Behavioral of Structural is


    component Shifter is
        Port ( 
           SHIFTCTRL : in STD_LOGIC_VECTOR (3 downto 0);
           SHIFTIN : in STD_LOGIC_VECTOR (N-1 downto 0);
           SHIFTOUT : out STD_LOGIC_VECTOR (N-1 downto 0));
        end component;

    component LUT is         --This needs to be modified to 16 Bits!!!
        Port ( 
            LUTIN : in STD_LOGIC_VECTOR (N-1 downto 0);
            CTRL:   in STD_LOGIC_VECTOR(3 downto 0);
            LUTOUT : out STD_LOGIC_VECTOR (N-1 downto 0));
        end component;
            
    component ALU is         --This needs to be modified to 16 Bits!!!
        Port ( CTRL : in STD_LOGIC_VECTOR (3 downto 0);
            A_BUS : in STD_LOGIC_VECTOR (N-1 downto 0);
            B_BUS : in STD_LOGIC_VECTOR (N-1 downto 0);
            ALU_OUT : out STD_LOGIC_VECTOR (N-1 downto 0));
        end component;

signal ALU_RESULT: std_logic_vector(N-1 downto 0);
signal SHIFTER_RESULT: std_logic_vector(N-1 downto 0);
signal LOOKUP_RESULT: std_logic_vector(N-1 downto 0);


begin

    MY_ALU:      ALU port map(CTRL,A_BUS,B_BUS,ALU_RESULT);
    MY_SHIFTER:  SHIFTER port map(CTRL,B_BUS,SHIFTER_RESULT);
    MY_LUT:      LUT port map(A_BUS,CTRL,LOOKUP_RESULT);

    process(ALU_RESULT,SHIFTER_RESULT,LOOKUP_RESULT)
    begin
        -- use of brackets for faster timing & efficient gates
        RESULT <= ALU_RESULT or (SHIFTER_RESULT or LOOKUP_RESULT);
    end process;
    
end Behavioral;
