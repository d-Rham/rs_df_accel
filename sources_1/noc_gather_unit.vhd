

--Network-on-chip microswitch gather bypass unit
--Forwards output psums emitted by PEs towards top level gather units

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH
USE IEEE.numeric_std.ALL;
USE work.rs_df_config.ALL;

ENTITY gather IS
    PORT(
        val_in : IN std_logic_vector(size-1 DOWNTO 0);
        val_out: OUT std_logic_vector(size-1 DOWNTO 0)
        );
end gather;

--Simple bypass bus

ARCHITECTURE behavioral of gather is
BEGIN
    val_out <= val_in;
END behavioral;
