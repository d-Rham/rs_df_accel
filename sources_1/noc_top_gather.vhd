
--Network-on-chip microswitch top gather unit
--Used by microswitches in the top level to route psums to GBM write port
--Controlled by priority logic defined outside of the scope of this entity

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
use work.rs_df_config.all;

ENTITY top_gather IS
    PORT(
        val_in_ver : IN std_logic_vector(size-1 DOWNTO 0);
        val_in_hor : IN std_logic_vector(size-1 DOWNTO 0);
        val_out : OUT std_logic_vector(size-1 DOWNTO 0);
        priority_sel: IN std_logic
    );

END top_gather;

ARCHITECTURE behavioral OF top_gather IS
BEGIN
gather: process
begin
    if(priority_sel = '1') then
        val_out <= val_in_hor;
    else
        val_out <= val_in_ver;
    end if;
 end process gather;
end behavioral;
                                                                    
