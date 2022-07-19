

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.rs_df_config.ALL;

ENTITY pe IS
   PORT( 
      data_av : IN std_logic_vector(1 DOWNTO 0);
      m1_in    : IN     std_logic_vector (size-1 DOWNTO 0);
      m2_in    : IN     std_logic_vector (size-1 DOWNTO 0);
      p_psum    : IN     std_logic_vector (size-1 DOWNTO 0);
      clk   : IN     std_logic;
      row   : OUT    std_logic_vector (size-1 DOWNTO 0)
      --row_hor   : OUT    std_logic_vector (size-1 DOWNTO 0)   
   );

-- Declarations
--attribute use_dsp : string; 
--attribute use_dsp of pe: entity is "yes";

END pe;



ARCHITECTURE struct OF pe IS

   -- Architecture declarations

   -- Internal signal declarations
   
      COMPONENT mac
   GENERIC (
      size : integer := 8
   );
   PORT (
      m1   : IN     std_logic_vector (size-1 DOWNTO 0);
      m2   : IN     std_logic_vector (size-1 DOWNTO 0);
      acc   : IN     std_logic_vector (size-1 DOWNTO 0);
      pout  : OUT    std_logic_vector (size-1 DOWNTO 0)
      
   );
   END COMPONENT;
   
   
   SIGNAL w_in : std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   SIGNAL act_in : std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   SIGNAL accum_in: std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   SIGNAL psum: std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   --SIGNAL p_psum: std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   SIGNAL write_m1: std_logic;
   SIGNAL write_m2: std_logic;
   SIGNAL write_a: std_logic;
   SIGNAL read: std_logic;
   SIGNAL reset: std_logic;
   SIGNAL flush:  std_logic;
   SIGNAL flush_out: std_logic_vector(size-1 DOWNTO 0);
   SIGNAL addr_m1:  std_logic_vector(rf_sel-1 DOWNTO 0);
   SIGNAL addr_m2:  std_logic_vector(rf_sel-1 DOWNTO 0);
   SIGNAL addr_a:  std_logic_vector(rf_sel-1 DOWNTO 0);
   SIGNAL addr_acc_flush : std_logic_vector(rf_sel-1 DOWNTO 0); 
    
   -- Component Declarations


   COMPONENT pe_control
 Port ( 
        clk: in std_logic;
        data_av: in std_logic_vector(1 DOWNTO 0);
        write_m1: out std_logic;
        write_m2: out std_logic;
        write_a: out std_logic;
        read: out std_logic;
        reset: out std_logic;
        flush: out std_logic;
        addr_m1: out std_logic_vector(rf_sel-1 DOWNTO 0);
        addr_m2: out std_logic_vector(rf_sel-1 DOWNTO 0);
        addr_a: out std_logic_vector(rf_sel-1 DOWNTO 0)
 
 );
 END COMPONENT;

Component pe_mem_scratch 
  Port (
   SIGNAL w_in : IN std_logic_vector(size-1 DOWNTO 0) ;
   SIGNAL act_in : IN std_logic_vector(size-1 DOWNTO 0);
   SIGNAL accum_in: IN std_logic_vector(size-1 DOWNTO 0);
   SIGNAL accum_out: OUT std_logic_vector(size-1 DOWNTO 0);
   SIGNAL flush_out: OUT std_logic_vector(size-1 DOWNTO 0);
   SIGNAL w_out : OUT std_logic_vector(size-1 DOWNTO 0) ;
   SIGNAL act_out : OUT std_logic_vector(size-1 DOWNTO 0);
   SIGNAL reset: IN std_logic;
   SIGNAL read: IN std_logic;
   SIGNAL write_in: IN std_logic;
   SIGNAL write_w: IN std_logic;
   SIGNAL write_acc: IN std_logic;
   SIGNAL clk: IN std_logic ;
   SIGNAL flush: IN std_logic;
   SIGNAL addr_m1: IN std_logic_vector(rf_sel-1 DOWNTO 0);
   SIGNAL addr_m2: IN std_logic_vector(rf_sel-1 DOWNTO 0);
   SIGNAL addr_acc: IN std_logic_vector(rf_sel-1 DOWNTO 0);
   SIGNAL addr_acc_flush: IN std_logic_vector(rf_sel-1 DOWNTO 0)
   );
end component;

   -- Optional embedded configurations
    
    --attribute use_dsp of mac: component is "yes";

BEGIN
   -- Instance port mappings.
  
  reg: pe_mem_scratch
  PORT MAP(
  clk => clk,
  w_in => m1_in,
  w_out => w_in,
  addr_m1 => addr_m1,
  write_w => write_m1,
  read => read,
  reset => reset,
  act_in => m2_in,
  act_out => act_in,
  addr_m2 => addr_m2,
  write_in => write_m2,
  accum_in => psum,
  accum_out => accum_in,
  addr_acc => addr_a,
  write_acc => write_a,
  addr_acc_flush => addr_acc_flush,
  flush => flush,
  flush_out => flush_out
  
  
  );
  
   U1 : mac
      GENERIC MAP (
         size => 8
      )
      PORT MAP (
         m1 => w_in,
         m2 => act_in,
         acc => accum_in,
         pout  => psum
      );
 
      
   cont: pe_control
        PORT MAP (
        clk => clk,
        data_av => data_av,
        write_m1 => write_m1,
        write_m2 => write_m2,
        write_a => write_a,
        read => read,
        reset => reset,
        flush => flush,
        addr_m1 => addr_m1,
        addr_m2 => addr_m2,
        addr_a => addr_a
        );                             
 -- signed(p_psum) +
 row <= (signed(p_psum) +signed(flush_out)) when (flush = '1') else (others => '0');
 --row_ver <= row when (ver_sel = '1') else (others => '0');
-- row_hor <= row when (hor_sel = '1') else (others => '0');
                      
END struct;
