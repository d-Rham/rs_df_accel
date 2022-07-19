

-- Network on Chip level 3
-- Contains bottom level microswitches, with bypass bus gather, and scatter logic for switches in the scatter tree
-- Level 3 contains 8 scatter tree switches


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.rs_df_config.ALL;

ENTITY noc_lvl_3 IS
   GENERIC( 
      size : integer := 8
   );
   PORT( 
      val_in_gthr: IN pe_net;
      val_out_gthr: OUT pe_net;
      val_in_sctr_1: IN sctr_2_branch;
      val_in_sctr_2: IN sctr_2_branch;
      val_out_sctr_1: OUT sctr_3_branch;
      val_out_sctr_2: OUT sctr_3_branch;
      sctr_cntrl: IN sctr_flow_3
   );

END noc_lvl_3;
 

ARCHITECTURE structural OF noc_lvl_3 IS

   COMPONENT noc_ms_btm_sctr
    PORT( 
       val_in_gthr : IN   std_logic_vector (size-1 DOWNTO 0);
       val_out_gthr: OUT std_logic_vector(size-1 DOWNTO 0);
       val_in_sctr_1: IN std_logic_vector(size-1 DOWNTO 0);
       val_in_sctr_2: IN std_logic_vector(size-1 DOWNTO 0);
       val_out_sctr_up_1: OUT std_logic_vector(size-1 DOWNTO 0);
       val_out_sctr_dn_1: OUT std_logic_vector(size-1 DOWNTO 0);
       val_out_sctr_up_2: OUT std_logic_vector(size-1 DOWNTO 0);
       val_out_sctr_dn_2: OUT std_logic_vector(size-1 DOWNTO 0);
       up_sel:IN std_logic;
       down_sel: IN std_logic
    );
   END COMPONENT; 

   COMPONENT noc_ms_btm
      PORT( 
         val_in_gthr : IN   std_logic_vector (size-1 DOWNTO 0);
         val_out_gthr: OUT std_logic_vector(size-1 DOWNTO 0)
      );
   END COMPONENT;

BEGIN
   -- Instance port mappings.
 M0 : noc_ms_btm PORT MAP (val_in_gthr(0),val_out_gthr(0));
 M1 : noc_ms_btm_sctr PORT MAP (val_in_gthr(1),val_out_gthr(1),val_in_sctr_1(0),val_in_sctr_2(0),val_out_sctr_1(0),val_out_sctr_1(1),val_out_sctr_2(0),val_out_sctr_2(1),sctr_cntrl(0), sctr_cntrl(1));  
 M2 : noc_ms_btm PORT MAP (val_in_gthr(2),val_out_gthr(2));
 M3 : noc_ms_btm_sctr PORT MAP (val_in_gthr(3),val_out_gthr(3),val_in_sctr_1(1),val_in_sctr_2(1),val_out_sctr_1(2),val_out_sctr_1(3),val_out_sctr_2(2),val_out_sctr_2(3),sctr_cntrl(2),sctr_cntrl(3));
 M4 : noc_ms_btm PORT MAP (val_in_gthr(4),val_out_gthr(4));
 M5 : noc_ms_btm_sctr PORT MAP (val_in_gthr(5),val_out_gthr(5),val_in_sctr_1(2),val_in_sctr_2(2),val_out_sctr_1(4),val_out_sctr_1(5),val_out_sctr_2(4),val_out_sctr_2(5),sctr_cntrl(4),sctr_cntrl(5));
 M6 : noc_ms_btm PORT MAP (val_in_gthr(6),val_out_gthr(6));
 M7 : noc_ms_btm_sctr PORT MAP (val_in_gthr(7),val_out_gthr(7),val_in_sctr_1(3),val_in_sctr_2(3),val_out_sctr_1(6),val_out_sctr_1(7),val_out_sctr_2(6),val_out_sctr_2(7),sctr_cntrl(6),sctr_cntrl(7));
 M8 : noc_ms_btm PORT MAP (val_in_gthr(8),val_out_gthr(8));
 M9 : noc_ms_btm_sctr PORT MAP (val_in_gthr(9),val_out_gthr(9),val_in_sctr_1(4),val_in_sctr_2(4),val_out_sctr_1(8),val_out_sctr_1(9),val_out_sctr_2(8),val_out_sctr_2(9),sctr_cntrl(8),sctr_cntrl(9));
 M10 : noc_ms_btm PORT MAP (val_in_gthr(10),val_out_gthr(10));
 M11 : noc_ms_btm_sctr PORT MAP (val_in_gthr(11),val_out_gthr(11),val_in_sctr_1(5),val_in_sctr_2(5),val_out_sctr_1(10),val_out_sctr_1(11),val_out_sctr_2(10),val_out_sctr_2(11),sctr_cntrl(10),sctr_cntrl(11));
 M12 : noc_ms_btm PORT MAP (val_in_gthr(12),val_out_gthr(12));
 M13 : noc_ms_btm_sctr PORT MAP (val_in_gthr(13),val_out_gthr(13),val_in_sctr_1(6),val_in_sctr_2(6),val_out_sctr_1(12),val_out_sctr_1(13),val_out_sctr_2(12),val_out_sctr_2(13),sctr_cntrl(12),sctr_cntrl(13));
 M14 : noc_ms_btm PORT MAP (val_in_gthr(14),val_out_gthr(14));
 M15 : noc_ms_btm_sctr PORT MAP (val_in_gthr(15),val_out_gthr(15),val_in_sctr_1(7),val_in_sctr_2(7),val_out_sctr_1(14),val_out_sctr_1(15),val_out_sctr_2(14),val_out_sctr_2(15),sctr_cntrl(14),sctr_cntrl(15));
END structural;
                                                                                                                                                     
