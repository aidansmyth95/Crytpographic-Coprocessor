library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LUT is
    Port ( 
           LUTIN : in STD_LOGIC_VECTOR (15 downto 0);
           CTRL:   in STD_LOGIC_VECTOR (3 downto 0);
           LUTOUT : out STD_LOGIC_VECTOR (15 downto 0));
end LUT;

architecture Behavioral of LUT is
    -- Input nibbles to LUT
    signal LINS1: std_logic_vector(3 downto 0);
    signal LINS2: std_logic_vector(3 downto 0);
    
    --Output nibbles from LUT   
    signal LOUTS1: std_logic_vector(3 downto 0);
    signal LOUTS2: std_logic_vector(3 downto 0);

    component LUT_S1 is          -- used for LSBs, S1
                port(
                    LUTIN         : in std_logic_vector(3 downto 0);
                    LUTOUT        : out std_logic_vector(3 downto 0)
                     );
            end component;
    
    component LUT_S2 is           --used for MSBs, S2
                port(
                    LUTIN         : in std_logic_vector(3 downto 0);
                    LUTOUT        : out std_logic_vector(3 downto 0)
                     );
            end component;



begin
    --Assign values to input signals
    LINS1 <= LUTIN(7 downto 4);
    LINS2 <= LUTIN(3 downto 0);
    
    -- Perform Lookup table operations
    Lookup_S1:  LUT_S1 port map(LINS1,LOUTS1);
    Lookup_S2:  LUT_S2 port map(LINS2,LOUTS2);


    -- assign signals to output when CTRL mathces, else output is zeros
    LUTOUT(15 downto 8) <= LUTIN(15 downto 8) when CTRL = "1100" else (others => '0');        
    LUTOUT(7 downto 4) <= LOUTS1 when CTRL = "1100" else (others => '0');        
    LUTOUT(3 downto 0) <= LOUTS2 when CTRL = "1100" else (others => '0');

end Behavioral;
