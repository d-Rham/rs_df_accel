
-- Network on Chip top level microswitch
-- Contains gather unit with priority logic selection
-- Contains scatter unit with selective targetting


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
use work.rs_df_config.all;

ENTITY noc_ms_top_main IS
   PORT( 
      val_in_gthr_hor : IN     std_logic_vector (size-1 DOWNTO 0);
      val_in_gthr_ver: IN std_logic_vector(size-1 DOWNTO 0);
      val_out_gthr: OUT std_logic_vector(size-1 DOWNTO 0);
      val_in_sctr_1: IN std_logic_vector(size-1 DOWNTO 0);
      val_in_sctr_2: IN std_logic_vector(size-1 DOWNTO 0);
      val_out_sctr_up_1: OUT std_logic_vector(size-1 DOWNTO 0);
      val_out_sctr_dn_1: OUT std_logic_vector(size-1 DOWNTO 0);
      val_out_sctr_up_2: OUT std_logic_vector(size-1 DOWNTO 0);
      val_out_sctr_dn_2: OUT std_logic_vector(size-1 DOWNTO 0);
      up_sel:IN std_logic;
      down_sel: IN std_logic;
      priority_sel: IN std_logic
   );
                                                                                            
END noc_ms_top_main;


--Main microswitch connected to GBM 
--Contains scatter unit as head node of scatter tree
--Contains gather unit with priority select for control flow
ARCHITECTURE structural OF noc_ms_top_main IS

   COMPONENT scatter
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
   END COMPONENT; 

   COMPONENT top_gather
   PORT (
      val_in_ver : IN     std_logic_vector (size-1 DOWNTO 0);
      val_in_hor : IN     std_logic_vector (size-1 DOWNTO 0);
      val_out : OUT    std_logic_vector(size-1 DOWNTO 0);
      priority_sel: IN std_logic
  );
   END COMPONENT;

BEGIN
   -- Instance port mappings.
   C0 : scatter
      PORT MAP (
         val_in_1  => val_in_sctr_1,
          val_in_2  => val_in_sctr_2,
          val_out_up_1 => val_out_sctr_up_1,
          val_out_dn_1  => val_out_sctr_dn_1,
          val_out_up_2 => val_out_sctr_up_2,
          val_out_dn_2  => val_out_sctr_dn_2,
          up_sel => up_sel,
          down_sel => down_sel
      );
      
   C1 : top_gather
      PORT MAP (
         val_in_ver => val_in_gthr_ver,
         val_in_hor => val_in_gthr_hor,
         val_out => val_out_gthr,
         priority_sel => priority_sel
     );
      
END structural;
                                                                                                
