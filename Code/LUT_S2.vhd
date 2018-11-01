library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LUT_S2 is
    port (
        LUTIN:         in  std_logic_vector(3 downto 0);
        LUTOUT:        out std_logic_vector(3 downto 0)    
    );
end entity;

architecture LUT of LUT_S2 is
    subtype LUKOUT is std_logic_vector (3 downto 0);    --A type for reference
    type LUT is array (natural range 0 to 15) of LUKOUT;
    constant lookuptable2:   LUT := (       --S2
        "1111", "0000", "1101", "0111", 
        "1011", "1110", "0101", "1100", 
        "1001", "0010", "1110", "0001",
        "0011", "0100", "1000", "0110"
        );
    signal tmp: std_logic_vector (3 downto 0);

begin
    tmp <= lookuptable2(TO_INTEGER(unsigned(LUTIN)));   --covert INPUT to int
    (LUTOUT(3),LUTOUT(2),LUTOUT(1),LUTOUT(0))<=LUKOUT'(tmp(3), tmp(2), tmp(1), tmp(0));
end architecture;
