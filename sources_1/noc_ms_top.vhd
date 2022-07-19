
-- Network on Chip top level microswitch
-- Contains gather unit with priority logic selection


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
use work.rs_df_config.all;

ENTITY noc_ms_top IS
   PORT( 
      val_in_gthr_hor : IN     std_logic_vector (size-1 DOWNTO 0);
      val_in_gthr_ver: IN std_logic_vector(size-1 DOWNTO 0);
      val_out_gthr: OUT std_logic_vector(size-1 DOWNTO 0);
      priority_sel: IN std_logic
   );

END noc_ms_top;


--Upper level microswitch routes data to main microswitch 
--Contains gather unit with priority select for control flow
ARCHITECTURE structural OF noc_ms_top IS

   COMPONENT top_gather
   PORT (
      val_in_ver : IN     std_logic_vector (size-1 DOWNTO 0);
      val_in_hor : IN     std_logic_vector (size-1 DOWNTO 0);
      val_out : OUT    std_logic_vector (size-1 DOWNTO 0);
      priority_sel: IN std_logic
  );
   END COMPONENT;

BEGIN
   -- Instance port mappings.
      
   C0 : top_gather
      PORT MAP (
         val_in_ver => val_in_gthr_ver,
         val_in_hor => val_in_gthr_hor,
         val_out => val_out_gthr,
         priority_sel => priority_sel
     );
      
END structural;
                                                                                                
