


LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
USE IEEE.NUMERIC_STD.ALL;

ENTITY row_stat_conv_pe_tb IS
END row_stat_conv_pe_tb;



ARCHITECTURE testbench OF row_stat_conv_pe_tb IS

   -- Architecture declarations

   -- Internal signal declarations
    SUBTYPE WORD is std_logic_vector(8-1 DOWNTO 0);
    SUBTYPE lookup is std_logic_vector(3-1 DOWNTO 0);
    SIGNAL m1_in : WORD := (others => '0');
    SIGNAL m2_in : WORD:= (others => '0');
    SIGNAL data_av : std_logic_vector(1 DOWNTO 0) := (others => '0');
    SIGNAL clk: std_logic := '1';
     SIGNAL p_psum: WORD:= (others => '0');
    SIGNAL psum: WORD:= (others => '0');
BEGIN
    dut: ENTITY work.pe 
        PORT MAP(
         m1_in   =>   m1_in,
         m2_in   =>    m2_in,
         clk         =>    clk ,
         p_psum       =>    p_psum,
         data_av => data_av,
         psum        =>    psum        
                );

    clock: PROCESS
    BEGIN
        clk <= not clk;
        wait for 5 ns;
    END PROCESS clock;

    dconv: PROCESS
    BEGIN
    wait until(rising_edge(clk));
    p_psum <= (others => '0');
    data_av <= "01";
    --3 cycle data read
    
    wait until(rising_edge(clk));
    m1_in <= x"FF";
    m2_in <= x"04";
    
    
    wait until(rising_edge(clk));
    m1_in <= x"00";
    m2_in <= x"03";
    
    wait until(rising_edge(clk));
    m1_in <= x"01";
    m2_in <= x"02";
    --load
     wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     wait until(rising_edge(clk));
     data_av <= "10";
     wait until(rising_edge(clk));
     m2_in <= x"06";
        
    --read 1
      
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
