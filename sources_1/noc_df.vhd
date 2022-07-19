LIBRARY ieee;
LIBRARY xil_defaultlib;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.rs_df_config.ALL;

ENTITY noc_df IS
   PORT( 
      val_in_gthr: IN pe_net;
      val_out_gthr: OUT std_logic_vector(size-1 DOWNTO 0);
      val_in_sctr_1: IN std_logic_vector(size-1 DOWNTO 0);
      val_in_sctr_2: IN std_logic_vector(size-1 DOWNTO 0);
      val_out_sctr_1: OUT pe_net;
      val_out_sctr_2: OUT pe_net;
      sctr_df_0: IN sctr_flow_0;
      sctr_df_1: IN sctr_flow_1;
      sctr_df_2: IN sctr_flow_2;
      sctr_df_3: IN sctr_flow_3;
      gthr_df: IN gthr_flow
   );

END noc_df;
 

ARCHITECTURE structural OF noc_df IS

   COMPONENT noc_lvl_0
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
   END COMPONENT; 

   COMPONENT noc_lvl_1
      PORT( 
         val_in_gthr : IN pe_net;
         val_out_gthr: OUT pe_net;
         val_in_sctr_1: IN sctr_0_branch;
         val_in_sctr_2: IN sctr_0_branch;
         val_out_sctr_1: OUT sctr_1_branch;
         val_out_sctr_2: OUT sctr_1_branch;
         sctr_cntrl: IN sctr_flow_1
      );
                                                
   END COMPONENT;

  COMPONENT noc_lvl_2
    PORT( 
       val_in_gthr : IN pe_net;
       val_out_gthr: OUT pe_net;
       val_in_sctr_1: IN sctr_1_branch;
       val_in_sctr_2: IN sctr_1_branch;
       val_out_sctr_1: OUT sctr_2_branch;
       val_out_sctr_2: OUT sctr_2_branch;
       sctr_cntrl: IN sctr_flow_2
    );
               
  END COMPONENT;
 COMPONENT noc_lvl_3
   PORT( 
      val_in_gthr : IN pe_net;
      val_out_gthr: OUT pe_net;
      val_in_sctr_1: IN sctr_2_branch;
      val_in_sctr_2: IN sctr_2_branch;
      val_out_sctr_1: OUT sctr_3_branch;
      val_out_sctr_2: OUT sctr_3_branch;
      sctr_cntrl: IN sctr_flow_3
   );
        
 END COMPONENT;
   SIGNAL lvl_0_gthr: pe_net;
   SIGNAL lvl_1_gthr: pe_net;
   SIGNAL lvl_2_gthr: pe_net;
   SIGNAL lvl_0_sctr_1: sctr_0_branch;
   SIGNAL lvl_0_sctr_2: sctr_0_branch;
   SIGNAL lvl_1_sctr_1: sctr_1_branch;
   SIGNAL lvl_1_sctr_2: sctr_1_branch;
   SIGNAL lvl_2_sctr_1: sctr_2_branch;
   SIGNAL lvl_2_sctr_2: sctr_2_branch;
   --SIGNAL sctr_df_0: sctr_flow_0;
   --SIGNAL sctr_df_1: sctr_flow_1;
   --SIGNAL sctr_df_2: sctr_flow_2;
   --SIGNAL sctr_df_3: sctr_flow_3;
   SIGNAL interm_out_1: sctr_3_branch;
   SIGNAL interm_out_2: sctr_3_branch;

BEGIN
--GEN_0:
--for i in sctr_df_0'range generate
--sctr_df_0(i) <= sctr_df(i);
--end generate GEN_0;
--GEN_1:
--for i in sctr_df_1'range generate
--sctr_df_0(i) <= sctr_df(i);
--end generate GEN_1;

--GEN_2:
--for i in sctr_df_2'range generate
--sctr_df_0(i) <= sctr_df(i);
--end generate GEN_2;

--GEN_3:
--for i in sctr_df_3'range generate
--sctr_df_3(i) <= sctr_df(i);
--end generate GEN_3;

GEN_O:
for i in interm_out_1'range generate
val_out_sctr_1(i) <= interm_out_1(i);
end generate GEN_O;

   -- Instance port mappings.
 L0 : noc_lvl_0 PORT MAP (lvl_0_gthr,val_out_gthr,val_in_sctr_1,val_in_sctr_2,lvl_0_sctr_1,lvl_0_sctr_2,sctr_df_0,gthr_df);
 L1 : noc_lvl_1 PORT MAP (lvl_1_gthr,lvl_0_gthr,lvl_0_sctr_1,lvl_0_sctr_2,lvl_1_sctr_1,lvl_1_sctr_2,sctr_df_1);
 L2 : noc_lvl_2 PORT MAP (lvl_2_gthr,lvl_1_gthr,lvl_1_sctr_1,lvl_1_sctr_2,lvl_2_sctr_1,lvl_2_sctr_2,sctr_df_2);
 L3 : noc_lvl_3 PORT MAP (val_in_gthr,lvl_2_gthr,lvl_2_sctr_1,lvl_2_sctr_2,interm_out_1,interm_out_2,sctr_df_3);

 end structural;
