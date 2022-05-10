


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY mac_tb IS
END mac_tb;



ARCHITECTURE testbench OF mac_tb IS

   -- Architecture declarations

   -- Internal signal declarations
    SUBTYPE WORD is std_logic_vector(8-1 DOWNTO 0);
    SUBTYPE lookup is std_logic_vector(3-1 DOWNTO 0);
    SIGNAL clk: std_logic := '0' ;
    SIGNAL reset: std_logic;
    SIGNAL psum: WORD;
    SIGNAL op1: WORD := (others=>'0');
    SIGNAL op2: WORD := (others=>'0');
    SIGNAL product: WORD;
BEGIN
dut:Entity work.mac
     PORT MAP (
         clk   => clk,
         op1   => op1,
         op2 => op2,
         reset => reset,
         psum  => psum,
         product => product
      );                                

     clock: process
     BEGIN
     clk <= not clk;
     wait for 2 ns;
 END PROCESS clock;

 multacc: PROCESS
 BEGIN
    wait for 3 ns;
    reset <= '0';
     wait for 2 ns;
     reset <= '1';
     op1 <= X"04";
     op2 <= X"FF";

     wait for 4 ns;
     op1 <= X"03";
     op2 <= X"00";

     wait for 4 ns;
     op1 <= X"02";
     op2 <= X"01";
     
     wait for 4 ns;
     reset <= '0';
     wait;

 end PROCESS multacc;

 end;

