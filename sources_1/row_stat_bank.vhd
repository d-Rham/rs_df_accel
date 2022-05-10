--TODO: think of isolating data-feed to each PE and handling everything through programmable memory controller, pushing data differently for different micro-operations
-- refactored, now think of SIMD execution

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


package pe_bank_metadata IS
constant kern_dim : integer := 3;
constant rows : integer := 3;
constant columns : integer := 3;
constant size : integer := 8;
constant cells: integer := 3;
type input_bus is array((kern_dim*kern_dim-(kern_dim-1)*(kern_dim-1))-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
type weight_bus is array(rows-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
type output_bus is array (columns-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
end package pe_bank_metadata;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.pe_bank_metadata.all;

ENTITY pe_bank IS
   GENERIC( 
      cells : integer := 3;
      size: integer := 8
   );
   PORT( 
      stat_in    : IN weight_bus;
      conv_in    : IN input_bus;
      data_av: IN std_logic_vector(1 DOWNTO 0);
      clk   : IN  std_logic;
      col_out   : OUT output_bus
   );

-- Declarations

END pe_bank;



ARCHITECTURE struct OF pe_bank IS

   -- Architecture declarations

   -- Internal signal declarations
    type partial_out is array(columns*(rows-1) - 1 DOWNTO 0) of std_logic_vector(7 DOWNTO 0);
    signal interm : partial_out;

   -- Component Declarations
   COMPONENT pe
   GENERIC( 
      cells :integer := 3;
      size : integer := 8;
      sel : integer := 9
   );
   PORT( 
      data_av : IN std_logic_vector(1 DOWNTO 0);
      clk   : IN     std_logic;
      p_psum    : IN     std_logic_vector (size-1 DOWNTO 0);
      m1_in    : IN     std_logic_vector (size-1 DOWNTO 0);
      m2_in    : IN     std_logic_vector (size-1 DOWNTO 0);
      row   : OUT    std_logic_vector (size-1 DOWNTO 0)
      );
   END COMPONENT;
 

   -- Optional embedded configurations


BEGIN
   -- Instance port mappings.
pe0: pe PORT MAP (data_av, clk, interm(0),stat_in(0), conv_in(0), col_out(0));
pe1: pe PORT MAP (data_av, clk, interm(1),stat_in(1), conv_in(1), interm(0));
pe2: pe PORT MAP (data_av, clk, x"00", stat_in(2), conv_in(2), interm(1));
pe3: pe PORT MAP (data_av, clk, interm(2), stat_in(0), conv_in(1), col_out(1));
pe4: pe PORT MAP (data_av, clk, interm(3), stat_in(1), conv_in(2), interm(2));
pe5: pe PORT MAP (data_av, clk, x"00", stat_in(2), conv_in(3), interm(3));
pe6: pe PORT MAP (data_av, clk, interm(4), stat_in(0), conv_in(2), col_out(2));
pe7: pe PORT MAP (data_av, clk, interm(5), stat_in(1), conv_in(3), interm(4));
pe8: pe PORT MAP (data_av, clk, x"00", stat_in(2), conv_in(4), interm(5));

END struct;
