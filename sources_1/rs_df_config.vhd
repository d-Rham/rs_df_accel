LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

package rs_df_config IS
constant kern_dim : integer := 3;
constant rows : integer := 3;
constant columns : integer := 3;
constant size : integer := 8;
constant sel : integer := 15;
constant rf_sel: integer := 8;
constant rf_cells: integer := 2**8;
constant cells: integer := 2**15;
constant pe_num: integer := 16;
constant sctr_0: integer := 2;
constant sctr_1: integer := 4;
constant sctr_2: integer := 8;
constant sctr_3: integer := 16;
constant sctr_flow_total: integer := 30;
--type input_bus is array(pe_num-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
--type weight_bus is array(pe_num-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
--type output_bus is array (columns- DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
type pe_net is array(pe_num-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
type gthr_flow is array(pe_num DOWNTO 0) of std_logic;
type sctr_0_branch is array(sctr_0-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
type sctr_1_branch is array(sctr_1-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
type sctr_2_branch is array(sctr_2-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
type sctr_3_branch is array(sctr_3-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
type sctr_flow_0 is array(sctr_0-1 DOWNTO 0) of std_logic;
type sctr_flow_1 is array(sctr_1-1 DOWNTO 0) of std_logic;
type sctr_flow_2 is array(sctr_2-1 DOWNTO 0) of std_logic;
type sctr_flow_3 is array(sctr_3-1 DOWNTO 0) of std_logic;
type sctr_dataflow is array(sctr_flow_total-1 DOWNTO 0) of std_logic;
end package rs_df_config;
                                                                                                                               
