

--Input data Register File
--Parallel and Serial Loading according to type of dataflow





LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.numeric_std.ALL;



package mem_bank_metadata IS
constant size : integer := 8;
constant cells: integer := 3;
type output_bank is array (cells-1 DOWNTO 0) of std_logic_vector(size-1 DOWNTO 0);
end package mem_bank_metadata;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.numeric_std.ALL;
USE work.mem_bank_metadata.ALL;

ENTITY mem_bank IS
    GENERIC( size: integer := 8;
             sel : integer := 8;
             cells: integer := 2**8
             );
    PORT(
    reset : IN std_logic;
    read : IN std_logic;
    write: IN std_logic;
    clk: IN std_logic;
    in_v: IN std_logic_vector(size-1 DOWNTO 0);
    out_vn: OUT output_bank;
    addr: IN std_logic_vector(sel-1 DOWNTO 0)
        );

  --attribute ram_style : string; 
  --attribute ram_style of mem_bank: entity is "block";
  
    END mem_bank;

ARCHITECTURE behav OF mem_bank IS
    subtype WORD is std_logic_vector(size-1 DOWNTO 0);
    type REG is array(cells-1 DOWNTO 0) of WORD;
    signal reg_write : REG := (others =>(others => '0'));
    attribute ram_style : string; 
    attribute ram_style of reg_write: signal is "block";
BEGIN
    operate: PROCESS (clk, reset, read, write)
    BEGIN 
    if rising_edge(clk) then
         if(write = '1') then --Universal write
             reg_write(to_integer(unsigned(addr))) <= in_v;
         end if;
         if(read = '1') then --Read
             out_vn(0) <= reg_write(to_integer(unsigned(addr)));
             out_vn(1) <= reg_write(to_integer(unsigned(addr))+1);
             out_vn(2) <= reg_write(to_integer(unsigned(addr))+2);
         end if;
         if (reset = '1') then
         out_vn <= (others=>(others => '0'));
          end if;
     end if;
    end PROCESS operate;
end behav;
    
