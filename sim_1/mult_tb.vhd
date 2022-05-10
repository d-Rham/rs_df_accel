


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY mult_tb IS
END mult_tb;



ARCHITECTURE testbench OF mult_tb IS

   -- Architecture declarations

   -- Internal signal declarations
    SUBTYPE WORD is std_logic_vector(8-1 DOWNTO 0);
    SUBTYPE lookup is std_logic_vector(3-1 DOWNTO 0);
    SIGNAL act_in: WORD;
    SIGNAL w_in: WORD;
    SIGNAL prod: WORD;
    SIGNAL product: WORD;
BEGIN
    DUT: ENTITY work.mult 
        PORT MAP(
         act_in => act_in,
         w_in => w_in,
         prod => prod,
         product => product
                );

    multip: PROCESS
    BEGIN
    wait for 5 ns;
    act_in <= X"04";
    w_in <= X"FF";
    wait for 5 ns;
    act_in <= X"03";
    w_in <= X"00";
    wait for 5 ns;
    act_in <= X"02";
    w_in <= X"01";
    wait;

        
    END PROCESS multip;

END;                                                                              
