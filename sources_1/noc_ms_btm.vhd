
-- Network on Chip bottom level microswitch
-- Contains gather unit as simple bus bypass
-- Contains no scatter unit


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
use work.rs_df_config.all;


ENTITY noc_ms_btm IS
   PORT( 
      val_in_gthr: IN std_logic_vector(size-1 DOWNTO 0);
      val_out_gthr: OUT std_logic_vector(size-1 DOWNTO 0)
   );

END noc_ms_btm;


--Bottom level microswitch 
--Only containts gather unit, not involved in scatter tree
--Contains gather unit with simple bus bypass, implemented this way for future extended pipelining considerations
ARCHITECTURE structural OF noc_ms_btm IS

   COMPONENT gather
   PORT (
      val_in : IN     std_logic_vector (size-1 DOWNTO 0);
      val_out : OUT    std_logic_vector (size-1 DOWNTO 0)
  );
   END COMPONENT;

BEGIN
   -- Instance port mappings.
      
   C0 : gather
      PORT MAP (
         val_in => val_in_gthr,
         val_out => val_out_gthr
     );
      
END structural;
                                                                                                                                 
