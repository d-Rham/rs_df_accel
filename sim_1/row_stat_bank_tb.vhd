


LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
USE IEEE.NUMERIC_STD.ALL;
USE work.pe_bank_metadata.all;

ENTITY row_stat_bank_tb IS
END row_stat_bank_tb;



ARCHITECTURE testbench OF row_stat_bank_tb IS

   -- Architecture declarations

   -- Internal signal declarations
    SUBTYPE WORD is std_logic_vector(8-1 DOWNTO 0);
    SIGNAL m1_in : weight_bus := (others =>(others => '0'));
    SIGNAL m2_in : input_bus:=  (others =>(others => '0'));
    SIGNAL data_av : std_logic_vector(1 DOWNTO 0) := (others => '0');
    SIGNAL clk: std_logic := '1';
    SIGNAL conv_out: output_bus:= (others =>(others => '0'));
BEGIN
    dut: ENTITY work.pe_bank 
        PORT MAP(
         stat_in   =>   m1_in,
         conv_in   =>    m2_in,
         clk         =>    clk ,
         data_av => data_av,
         col_out    =>  conv_out       
                );

    clock: PROCESS
    BEGIN
        clk <= not clk;
        wait for 5 ns;
    END PROCESS clock;

    dconv: PROCESS
    BEGIN
    wait until(rising_edge(clk));
    data_av <= "01";
    --3 cycle data read
    
    wait until(rising_edge(clk));
    m1_in <= (x"FF",x"FE",x"FF");
    m2_in <= (x"04", x"01",x"02",x"05",x"02");
    
    
    wait until(rising_edge(clk));
     m1_in <= (x"00",x"00",x"00");
    m2_in <= (x"03", x"04",x"01",x"06",x"01");
    
    wait until(rising_edge(clk));
     m1_in <= (x"01",x"02",x"01");
    m2_in <= (x"02", x"05",x"03",x"00",x"00");
    --load
     wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     data_av <= "10";
     wait until(rising_edge(clk));
     m2_in <= (x"06", x"03",x"01",x"00",x"03");
        
    --read 1
       wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     data_av <= "10";
     wait until(rising_edge(clk));
     m2_in <= (x"03", x"02",x"05",x"03",x"00");
     -- read 2  
     --read 3
       wait until(rising_edge(clk));

       --load sr
       wait until(rising_edge(clk));
      
       
       -- read 1
       wait until(rising_edge(clk));
     
       
       --read 2
       wait until(rising_edge(clk));
        data_av <= "00";
        
       --read 3          
       wait until(rising_edge(clk));
        
         --load sr
       wait until(rising_edge(clk));
    
       
       -- read 1
       wait until(rising_edge(clk));
    
       
       --read 2
       wait until(rising_edge(clk));
         
        
       --read 3          
       wait until(rising_edge(clk));
     
        
        --Idle                   
        wait until rising_edge(clk);
        
        wait until rising_edge(clk);
        
        
        wait until rising_edge(clk);
        
        wait;

    END PROCESS dconv;

END;
