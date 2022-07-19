--TODO: think of isolating data-feed to each PE and handling everything through programmable memory controller, pushing data differently for different micro-operations
-- refactored, now think of SIMD execution
                           

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE work.rs_df_config.all;

ENTITY pe_bank IS
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
pe0: pe PORT MAP (data_av, clk, x"00",stat_in(0), conv_in(0), psum_out(0));
pe1: pe PORT MAP (data_av, clk, x"00",stat_in(1), conv_in(1), psum_out(1));
pe2: pe PORT MAP (data_av, clk, x"00", stat_in(2), conv_in(2), psum_out(2));
pe3: pe PORT MAP (data_av, clk, x"00", stat_in(3), conv_in(3), psum_out(3));
pe4: pe PORT MAP (data_av, clk, x"00", stat_in(4), conv_in(4), psum_out(4));
pe5: pe PORT MAP (data_av, clk, x"00", stat_in(5), conv_in(5), psum_out(5));
pe6: pe PORT MAP (data_av, clk, x"00", stat_in(6), conv_in(6), psum_out(6));
pe7: pe PORT MAP (data_av, clk, x"00", stat_in(7), conv_in(7), psum_out(7));
pe8: pe PORT MAP (data_av, clk, x"00", stat_in(8), conv_in(8), psum_out(8));
pe9: pe PORT MAP (data_av, clk, x"00",stat_in(9), conv_in(9), psum_out(9));
pe10: pe PORT MAP (data_av, clk, x"00",stat_in(10), conv_in(10), psum_out(10));
pe11: pe PORT MAP (data_av, clk, x"00",stat_in(11), conv_in(11), psum_out(11));
pe12: pe PORT MAP (data_av, clk, x"00",stat_in(12), conv_in(12), psum_out(12));
pe13: pe PORT MAP (data_av, clk, x"00",stat_in(13), conv_in(13), psum_out(13));
pe14: pe PORT MAP (data_av, clk, x"00",stat_in(14), conv_in(14), psum_out(14));
pe15: pe PORT MAP (data_av, clk, x"00",stat_in(15), conv_in(15), psum_out(15));

END struct;
