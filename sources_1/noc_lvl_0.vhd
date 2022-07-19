
-- Network on Chip level 0
-- Contains main microswitch, with both scatter and gather units
-- Contains side microswitches, with priority selection gather units


LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.numeric_std.ALL;
USE work.rs_df_config.ALL;

ENTITY noc_lvl_0 IS
   GENERIC( 
      size : integer := 8
   );
   PORT( 
      val_in_gthr: IN pe_net;
      val_out_gthr: OUT std_logic_vector(size-1 DOWNTO 0);
      val_in_sctr_1: IN std_logic_vector(size-1 DOWNTO 0);
      val_in_sctr_2: IN std_logic_vector(size-1 DOWNTO 0);
      val_out_sctr_1: OUT sctr_0_branch;
      val_out_sctr_2: OUT sctr_0_branch;
      sctr_cntrl: IN sctr_flow_0;
      gthr_cntrl: IN gthr_flow
   );

END noc_lvl_0;
 

ARCHITECTURE structural OF noc_lvl_0 IS

   COMPONENT noc_ms_top_main 
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
   END COMPONENT; 

   COMPONENT noc_ms_top
      PORT( 
         val_in_gthr_hor : IN     std_logic_vector (size-1 DOWNTO 0);
         val_in_gthr_ver: IN std_logic_vector(size-1 DOWNTO 0);
         val_out_gthr: OUT std_logic_vector(size-1 DOWNTO 0);
         priority_sel: IN std_logic
      );
   END COMPONENT;

   SIGNAL interm_gthr: pe_net;

BEGIN
   -- Instance port mappings.
 M0 : noc_ms_top PORT MAP (x"00",val_in_gthr(0),interm_gthr(0), gthr_cntrl(0));
 M1 : noc_ms_top PORT MAP (interm_gthr(0),val_in_gthr(1),interm_gthr(1), gthr_cntrl(1));   
 M2 : noc_ms_top PORT MAP (interm_gthr(1),val_in_gthr(2),interm_gthr(2), gthr_cntrl(2));
 M3 : noc_ms_top PORT MAP (interm_gthr(2),val_in_gthr(3),interm_gthr(3), gthr_cntrl(3));
 M4 : noc_ms_top PORT MAP (interm_gthr(3),val_in_gthr(4),interm_gthr(4), gthr_cntrl(4));
 M5 : noc_ms_top PORT MAP (interm_gthr(4),val_in_gthr(5),interm_gthr(5), gthr_cntrl(5));
 M6 : noc_ms_top PORT MAP (interm_gthr(5),val_in_gthr(6),interm_gthr(6), gthr_cntrl(6));
 M7 : noc_ms_top PORT MAP (interm_gthr(6),val_in_gthr(7),interm_gthr(7), gthr_cntrl(7));
 M8 : noc_ms_top PORT MAP (x"00",val_in_gthr(8),interm_gthr(8),gthr_cntrl(8));
 M9 : noc_ms_top PORT MAP (interm_gthr(8),val_in_gthr(9),interm_gthr(9), gthr_cntrl(9));
 M10 : noc_ms_top PORT MAP (interm_gthr(9),val_in_gthr(10),interm_gthr(10), gthr_cntrl(10));
 M11 : noc_ms_top PORT MAP (interm_gthr(10),val_in_gthr(11),interm_gthr(11), gthr_cntrl(11));
 M12 : noc_ms_top PORT MAP (interm_gthr(11),val_in_gthr(12),interm_gthr(12), gthr_cntrl(12));
 M13 : noc_ms_top PORT MAP (interm_gthr(12),val_in_gthr(13),interm_gthr(13), gthr_cntrl(13));
 M14 : noc_ms_top PORT MAP (interm_gthr(13),val_in_gthr(14),interm_gthr(14), gthr_cntrl(14));
 M15 : noc_ms_top PORT MAP (interm_gthr(14),val_in_gthr(15),interm_gthr(15), gthr_cntrl(15));
 M16 : noc_ms_top_main PORT MAP (interm_gthr(7),interm_gthr(15),val_out_gthr,val_in_sctr_1,val_in_sctr_2,val_out_sctr_1(0),val_out_sctr_1(1),val_out_sctr_2(0),val_out_sctr_2(1),sctr_cntrl(0),sctr_cntrl(1),gthr_cntrl(16));
END structural;
                                                                                                                                                                         
