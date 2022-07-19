                                                                                                                                                                         
 -- Network on Chip bottom level microswitch with scatter
 -- Contains gather unit as simple bus bypass
 -- Contains scatter unit as part of scatter tree branches
 
 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;
 USE IEEE.STD_LOGIC_ARITH.ALL;
 
 
 ENTITY noc_ms_btm_sctr IS
    GENERIC( 
       size : integer := 8
    );
    PORT( 
       val_in_gthr: IN     std_logic_vector (size-1 DOWNTO 0);
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
 
 END noc_ms_btm_sctr;
 
 
 --Main microswitch connected to GBM 
 --Contains scatter unit as head node of scatter tree
 --Contains gather unit with priority select for control flow
 ARCHITECTURE structural OF noc_ms_btm_sctr IS
 
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
 
    COMPONENT gather
    PORT (
       val_in : IN     std_logic_vector (size-1 DOWNTO 0);
       val_out : OUT    std_logic_vector (size-1 DOWNTO 0)
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
       
    C1 : gather
       PORT MAP (
          val_in => val_in_gthr,
          val_out => val_out_gthr
      );
       
 END structural;
                                                                                                 
