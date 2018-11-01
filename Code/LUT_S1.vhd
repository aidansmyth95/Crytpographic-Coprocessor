library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LUT_S1 is
    port (
        LUTIN:         in  std_logic_vector(3 downto 0);
        LUTOUT:        out std_logic_vector(3 downto 0)    
    );
end entity;

architecture LUT of LUT_S1 is
    subtype LUKOUT is std_logic_vector (3 downto 0);    --A type for reference
    type LUT is array (natural range 0 to 15) of LUKOUT;
    constant lookuptable1:   LUT := (       --S2
        "0001", "1011", "1001", "1100", 
        "1101", "0110", "1111", "0011", 
        "1110", "1000", "0111", "0100",
        "1010", "0010", "0101", "0000"
        );
    signal tmp: std_logic_vector (3 downto 0);

begin
    tmp <= lookuptable1(TO_INTEGER(unsigned(LUTIN)));   --covert INPUT to int
    (LUTOUT(3),LUTOUT(2),LUTOUT(1),LUTOUT(0))<=LUKOUT'(tmp(3), tmp(2), tmp(1), tmp(0));
end architecture;
