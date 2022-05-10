
--Base Multiplier
--TODO: Catch undefined cases (Zero operands), Handle overflow

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY mult IS
    GENERIC( size: integer := 8 );
    PORT(
    m1 : IN std_logic_vector (size-1 DOWNTO 0);
    m2 : IN std_logic_vector (size-1 DOWNTO 0);
    prod: OUT std_logic_vector (size-1 DOWNTO 0)
        );

END mult;

ARCHITECTURE behav OF mult IS
BEGIN
    multiply: PROCESS (m1, m2)
    VARIABLE mtemp: std_logic_vector(2*size-1 DOWNTO 0);
    BEGIN
        mtemp := (signed(m1) * signed(m2));
        prod <= mtemp(size-1 DOWNTO 0);
    END PROCESS multiply;

END behav;
