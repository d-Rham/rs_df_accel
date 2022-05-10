

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY pe IS
   GENERIC( 
      cells :integer := 3;
      size : integer := 8;
      sel : integer := 9
   );
   PORT( 
      data_av : IN std_logic_vector(1 DOWNTO 0);
      m1_in    : IN     std_logic_vector (size-1 DOWNTO 0);
      m2_in    : IN     std_logic_vector (size-1 DOWNTO 0);
      p_psum    : IN     std_logic_vector (size-1 DOWNTO 0);
      clk   : IN     std_logic;
      row   : OUT    std_logic_vector (size-1 DOWNTO 0)
   );

-- Declarations
--attribute use_dsp : string; 
--attribute use_dsp of pe: entity is "yes";

END pe;



ARCHITECTURE struct OF pe IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL w_in : std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   SIGNAL act_in : std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   SIGNAL accum_in: std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   SIGNAL psum: std_logic_vector(size-1 DOWNTO 0) := (others => '0');
   SIGNAL write_m1: std_logic;
   SIGNAL write_m2: std_logic;
   SIGNAL write_a: std_logic;
   SIGNAL read: std_logic;
   SIGNAL reset: std_logic;
   SIGNAL flush_out:  std_logic;
   SIGNAL addr_m1:  std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_m2:  std_logic_vector(sel-1 DOWNTO 0);
   SIGNAL addr_a:  std_logic_vector(sel-3 DOWNTO 0);
    
    
   -- Component Declarations
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
   
   COMPONENT reg_file
    GENERIC( size: integer := 8;
             sel : integer := 9;
             cells: integer := 2**9 - 2**6
             );
    PORT(
    reset : IN std_logic;
    read : IN std_logic;
    write: IN std_logic;
    clk: IN std_logic;
    in_m: IN std_logic_vector(size-1 DOWNTO 0);
    out_m: OUT std_logic_vector(size-1 DOWNTO 0);
    addr: IN std_logic_vector(sel-1 DOWNTO 0)
        );
   END COMPONENT;



   COMPONENT pe_control
   generic(
 sel : integer := 9
 );
 Port ( 
        clk: in std_logic;
        data_av: in std_logic_vector(1 DOWNTO 0);
        write_m1: out std_logic;
        write_m2: out std_logic;
        write_a: out std_logic;
        read: out std_logic;
        reset: out std_logic;
        flush_out: out std_logic;
        addr_m1: out std_logic_vector(sel-1 DOWNTO 0);
        addr_m2: out std_logic_vector(sel-1 DOWNTO 0);
        addr_a: out std_logic_vector(sel-3 DOWNTO 0)
 
 );
 END COMPONENT;


   -- Optional embedded configurations
    
    --attribute use_dsp of mac: component is "yes";

BEGIN
   -- Instance port mappings.
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
   reg1 : reg_file
      GENERIC MAP (
         size => 8,
         sel => 9,
         cells => 2**9 - 2**6
      )
      PORT MAP (
         clk => clk,
         in_m => m1_in,
         out_m => w_in,
         addr => addr_m1,
         write => write_m1,
         read => read,
         reset => reset
      ); 
   reg2 : reg_file
      GENERIC MAP (
         size => 8,
         sel => 9,
         cells => 2**9 - 2**6
      )
      PORT MAP (
         clk => clk,
         in_m => m2_in,
         out_m => act_in,
         addr => addr_m2,
         write => write_m2,
         read => read,
         reset => reset
      ); 
   rega : reg_file
      GENERIC MAP (
         size => 8,
         sel => 7,
         cells => 2**7
      )
      PORT MAP (
         clk => clk,
         in_m => psum,
         out_m => accum_in,
         addr => addr_a,
         write => write_a,
         read => read,
         reset => reset
      );   
      
   cont: pe_control
        GENERIC MAP (
        sel => 9 
        )
        PORT MAP (
        clk => clk,
        data_av => data_av,
        write_m1 => write_m1,
        write_m2 => write_m2,
        write_a => write_a,
        read => read,
        reset => reset,
        flush_out => flush_out,
        addr_m1 => addr_m1,
        addr_m2 => addr_m2,
        addr_a => addr_a
        );                             
 row <= ( signed(accum_in) + signed(p_psum)) when (flush_out = '1') else (others => '0');
                      
END struct;
