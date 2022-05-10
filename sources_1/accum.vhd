

--Accumulator


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY accum IS
    GENERIC( size: integer := 8);
    PORT(
    prod: IN std_logic_vector(size-1 DOWNTO 0);
    acc: IN std_logic_vector(size-1 DOWNTO 0);
    psum : OUT std_logic_vector(size-1 DOWNTO 0)
        );

END accum;

ARCHITECTURE behav OF accum IS

BEGIN
    accumulate: PROCESS (prod,acc)
    BEGIN
             psum <= signed(prod) + signed(acc);
    END PROCESS accumulate;
END behav;

