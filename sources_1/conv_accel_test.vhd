


LIBRARY ieee;
LIBRARY xil_defaultlib;
USE ieee.std_logic_1164.all;
--USE IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;
USE work.rs_df_config.ALL;



entity conv_accel_test is
Port ( 
      sctr_df_0: IN sctr_flow_0;
      sctr_df_1: IN sctr_flow_1;
      sctr_df_2: IN sctr_flow_2;
      sctr_df_3: IN sctr_flow_3;
      gthr_df: IN gthr_flow;
      clk: IN std_logic;
         
   SIGNAL wk_in : IN std_logic_vector(size-1 DOWNTO 0) ;
   SIGNAL ifm_in : IN std_logic_vector(size-1 DOWNTO 0);
   --SIGNAL ofm_in: IN std_logic_vector(size-1 DOWNTO 0);
   
  -- SIGNAL wk_out: OUT std_logic_vector(size-1 DOWNTO 0);
   --SIGNAL ifm_out : OUT std_logic_vector(size-1 DOWNTO 0) ;
   SIGNAL ofm_out : OUT std_logic_vector(size-1 DOWNTO 0);
   
   SIGNAL reset_wk: IN std_logic;
   SIGNAL reset_ifm: IN std_logic;
   SIGNAL reset_ofm: IN std_logic;
   
   SIGNAL read_wk: IN std_logic;
   SIGNAL read_ifm: IN std_logic;
   SIGNAL read_ofm: IN std_logic;
   
   SIGNAL write_wk: IN std_logic;
   SIGNAL write_ifm: IN std_logic;
   SIGNAL write_ofm: IN std_logic;
   
   SIGNAL addr_wk_a: IN std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_ifm_a: IN std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_ofm_a: IN std_logic_vector(sel-1 DOWNTO 0);
   
   SIGNAL addr_wk_b: IN std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_ifm_b: IN std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_ofm_b: IN std_logic_vector(sel-1 DOWNTO 0)
);
end conv_accel_test;

architecture structural of conv_accel_test is

COMPONENT global_buff_mem

    PORT(
   SIGNAL clk: IN std_logic ;
    
   SIGNAL wk_in : IN std_logic_vector(size-1 DOWNTO 0) ;
   SIGNAL ifm_in : IN std_logic_vector(size-1 DOWNTO 0);
   SIGNAL ofm_in: IN std_logic_vector(size-1 DOWNTO 0);
   
   SIGNAL wk_out: OUT std_logic_vector(size-1 DOWNTO 0);
   SIGNAL ifm_out : OUT std_logic_vector(size-1 DOWNTO 0) ;
   SIGNAL ofm_out : OUT std_logic_vector(size-1 DOWNTO 0);
   
   SIGNAL reset_wk: IN std_logic;
   SIGNAL reset_ifm: IN std_logic;
   SIGNAL reset_ofm: IN std_logic;
   
   SIGNAL read_wk: IN std_logic;
   SIGNAL read_ifm: IN std_logic;
   SIGNAL read_ofm: IN std_logic;
   
   SIGNAL write_wk: IN std_logic;
   SIGNAL write_ifm: IN std_logic;
   SIGNAL write_ofm: IN std_logic;
   
   SIGNAL addr_wk_a: IN std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_ifm_a: IN std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_ofm_a: IN std_logic_vector(sel-1 DOWNTO 0);
   
   SIGNAL addr_wk_b: IN std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_ifm_b: IN std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_ofm_b: IN std_logic_vector(sel-1 DOWNTO 0)
        );
  END COMPONENT;
  
COMPONENT noc_df

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
 END COMPONENT;
 
COMPONENT pe_bank
    GENERIC( 
      cells : integer := 3;
      size: integer := 8
   );
   PORT( 
      stat_in    : IN pe_net;
      conv_in    : IN pe_net;
      data_av: IN std_logic_vector(1 DOWNTO 0);
      clk   : IN  std_logic;
      psum_out   : OUT pe_net
   );
END COMPONENT;

SIGNAL noc_in_sctr_1: std_logic_vector(size-1 DOWNTO 0);
SIGNAL noc_in_sctr_2: std_logic_vector(size-1 DOWNTO 0);
SIGNAL noc_out_gthr: std_logic_vector(size-1 DOWNTO 0);
SIGNAL noc_out_sctr_1: pe_net;
SIGNAL noc_out_sctr_2: pe_net;
SIGNAL noc_in_gthr: pe_net;

begin

--Instance port mapping 

E0: global_buff_mem PORT MAP (clk, wk_in,ifm_in,noc_out_gthr,noc_in_sctr_1,noc_in_sctr_2,ofm_out,reset_wk,reset_ifm,reset_ofm, read_wk,read_ifm,read_ofm, write_wk, write_ifm, write_ofm, addr_wk_a,addr_ifm_a,addr_ofm_a , addr_wk_b,addr_ifm_b,addr_ofm_b);
E1: noc_df PORT MAP (noc_in_gthr, noc_out_gthr, noc_in_sctr_1, noc_in_sctr_2,noc_out_sctr_1, noc_out_sctr_2,sctr_df_0,sctr_df_1, sctr_df_2, sctr_df_3, gthr_df);
E2: pe_bank PORT MAP (noc_out_sctr_1, noc_out_sctr_2, "00", clk, noc_in_gthr);


end structural;
