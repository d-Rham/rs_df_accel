

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;


ENTITY conv_reg_file_tb IS
END conv_reg_file_tb;



ARCHITECTURE testbench OF conv_reg_file_tb IS
    SUBTYPE WORD is std_logic_vector(8-1 DOWNTO 0);
    SUBTYPE at IS std_logic_vector(3-1 DOWNTO 0);
    signal clk: std_logic := '0' ;
    signal read : std_logic;
    signal write: std_logic;
    signal write_sr : std_logic;
    signal reg_in_0: WORD;
    signal reg_in_1: WORD;
    signal reg_in_2: WORD;
    signal reg_out: WORD;
    signal addr: at;

BEGIN
DUT: ENTITY work.conv_reg_file
    PORT MAP (
        clk => clk,
        read => read,
        write => write,
        write_sr => write_sr,
        reg_in_0 => reg_in_0,
        reg_in_1 => reg_in_1,
        reg_in_2 => reg_in_2,
        reg_out => reg_out,
        addr => addr
             );


    clock : PROCESS
     BEGIN
     clk <= not clk;
     wait for 50 ns;
     end PROCESS clock;

    srreg: PROCESS
    BEGIN
    reg_in_0 <= X"04";
    reg_in_1 <= X"03";
    reg_in_2 <= X"02";

    wait until rising_edge(clk);
    write <= '1';
    
    Wait until rising_edge(clk);
    write <= '0';
    addr <= "000";
    read <= '1';

    wait until rising_edge(clk);
    addr <= "001";
    
    wait until rising_edge(clk);
    addr <= "010";
    
    wait until rising_edge(clk);
    read <= '0';                       
    reg_in_2 <= X"06";
    write_sr <= '1';
   

    wait until rising_edge(clk);
    write_sr <= '0';
    addr <="000";
    read <= '1';
  
     wait until rising_edge(clk);    
     addr <= "001";
                                
     wait until rising_edge(clk);
     addr <= "010";
                                  
    wait until rising_edge(clk);
     read <= '0';                 

    wait;


    END PROCESS srreg;
end;
