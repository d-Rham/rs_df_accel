
--Network-on-chip switch scatter unit
--Used by microswitches in the NoC scatter tree to transmit data from Global Buffer Memory to PE array

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH
USE IEEE.numeric_std.ALL;
use work.rs_df_config.all;

ENTITY scatter IS
    PORT(
        val_in_1 : IN std_logic_vector(size-1 DOWNTO 0);
        val_in_2 : IN std_logic_vector(size-1 DOWNTO 0);
        val_out_up_1 : OUT std_logic_vector(size-1 DOWNTO 0);
        val_out_dn_1 : OUT std_logic_vector(size-1 DOWNTO 0);
        val_out_up_2 : OUT std_logic_vector(size-1 DOWNTO 0);
        val_out_dn_2 : OUT std_logic_vector(size-1 DOWNTO 0);
        up_sel: IN std_logic;               
        down_sel: IN std_logic 
    );

END scatter;

ARCHITECTURE behavioral OF scatter IS
BEGIN
scatter: process 
BEGIN
    if(up_sel = '1') then
        val_out_up_1 <= val_in_1;
        val_out_up_2 <= val_in_2;
    else
        val_out_up_1 <= (others => '0');
        val_out_up_2 <= (others => '0');
    end if;

    if(down_sel = '1') then
        val_out_dn_1 <= val_in_1;
        val_out_dn_2 <= val_in_2;
    else
        val_out_dn_1 <= (others => '0');
        val_out_dn_2 <= (others => '0');
    end if;
   END PROCESS scatter;
end behavioral;
                                                                    
