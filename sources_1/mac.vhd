
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;


ENTITY mac IS
   GENERIC( 
      size : integer := 8
   );
   PORT( 
      m1    : IN     std_logic_vector (size-1 DOWNTO 0);
      m2    : IN     std_logic_vector (size-1 DOWNTO 0);
      acc: IN std_logic_vector(size-1 DOWNTO 0);
      pout   : OUT    std_logic_vector (size-1 DOWNTO 0)
   );

-- Declarations
    --attribute use_dsp48: string;
    --attribute use_dsp48 of mac: entity is "yes";
END mac ;



ARCHITECTURE struct OF mac IS

   -- Architecture declarations
    --attribute use_dsp48 of struct: architecture is "yes";
   -- Internal signal declarations
   SIGNAL prod : std_logic_vector(size-1 DOWNTO 0);
   SIGNAL temp_sum: std_logic_vector(size-1 DOWNTO 0);


   -- Component Declarations
   COMPONENT accum
   GENERIC (
      size : integer := 8
   );
   PORT (
      prod   : IN     std_logic_vector (size-1 DOWNTO 0);
      acc: IN std_logic_vector(size-1 DOWNTO 0);
      psum  : OUT std_logic_vector (size-1 DOWNTO 0)
         );
   END COMPONENT;
   COMPONENT mult
   GENERIC (
      size : integer := 8
   );
   PORT (
      m1 : IN     std_logic_vector (size-1 DOWNTO 0);
      m2 : IN     std_logic_vector (size-1 DOWNTO 0);
      prod : OUT    std_logic_vector (size-1 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
    --attribute use_dsp48 of mult: component is "yes";
    --attribute use_dsp48 of accum: component is "yes";

BEGIN
   -- Instance port mappings.
   I0 : accum
      GENERIC MAP (
         size => 8
      )
      PORT MAP (
         prod   => prod,
         acc => acc,
         psum  => pout
      );
      
   I1 : mult
      GENERIC MAP (
         size => 8
      )
      PORT MAP (
         m1 => m1,
         m2 => m2,
         prod => prod
      );
      
 -- zerogate: process (temp_sum, p_psum)
 -- begin
  --   end process zerogate;
END struct;
