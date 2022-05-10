
--Input data Register File
--Parallel and Serial Loading according to type of dataflow


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.numeric_std.ALL;

ENTITY reg_file IS
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

END reg_file;

ARCHITECTURE behav OF reg_file IS
    subtype WORD is std_logic_vector(size-1 DOWNTO 0);
    type REG is array(cells-1 DOWNTO 0) of WORD;
    signal temp_out: WORD := (others => '0');
    signal reg_write : REG := (others =>(others => '0'));
BEGIN
    operate: PROCESS (clk, reset, read, write)
    BEGIN 
    if rising_edge(clk) then
         if(write = '1') then --Universal write
             reg_write(to_integer(unsigned(addr))) <= in_m;
         end if;
         if(read = '1') then --Read
             out_m <= reg_write(to_integer(unsigned(addr)));
         if ( write = '1') then
         out_m <= in_m;
         end if;
         end if;
         if (reset = '1') then
         out_m <= (others => '0');
          end if;
     end if;
    end PROCESS operate;
end behav;
    
