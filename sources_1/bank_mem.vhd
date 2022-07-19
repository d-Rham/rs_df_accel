

-- Register file memory unit
-- ~1 KB memory to hold activations, filter weights and output psums
-- If all goes well, it should infer BRAMs on XST (Xilinx synthesis tool)
-- **************************************************************************************************************
-- Caveat: Write enable activates both write ports, so to avoid corrupting a vital address when doing single port write
-- point 2nd write address to the very last address in block, which works as a "sink address" for now.
LIBRARY IEEE;
LIBRARY xil_defaultlib;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.numeric_std.ALL;
USE work.rs_df_config.ALL;


--Dual port memory
--Seperate address and enable signals for each port to enable seperate access
ENTITY mem_bank IS
    PORT(
     clk: IN std_logic;
    
    reset_a : IN std_logic;
    read_a : IN std_logic;
    write_a: IN std_logic;
    val_wr_a: IN std_logic_vector(size-1 DOWNTO 0);
    val_rd_a: OUT std_logic_vector(size-1 DOWNTO 0);
    addr_a: IN std_logic_vector(sel-1 DOWNTO 0);
    
    reset_b: IN std_logic;
    read_b : IN std_logic;
    write_b: IN std_logic;
    val_wr_b: IN std_logic_vector(size-1 DOWNTO 0);
    val_rd_b: OUT std_logic_vector(size-1 DOWNTO 0);
    addr_b: IN std_logic_vector(sel-1 DOWNTO 0)
        );

  --attribute ram_style : string; 
  --attribute ram_style of mem_bank: entity is "block";
    END mem_bank;

ARCHITECTURE behav OF mem_bank IS
    --WORD = basic computation data word size, eg: INT8
    subtype WORD is std_logic_vector(size-1 DOWNTO 0);
    type REG is array(cells-1 DOWNTO 0) of WORD;
    signal reg_cell : REG := (others =>(others => '0'));

    attribute ram_style : string; 
    attribute ram_style of reg_cell: signal is "block";
BEGIN
    PORT_A: PROCESS (clk, reset_a, read_a, write_a)
    BEGIN 
    if rising_edge(clk) then
         if(write_a = '1') then --Write enable to A port
            reg_cell(to_integer(unsigned(addr_a))) <= val_wr_a;
        end if;
         if(read_a = '1') then --Read enable from A port
             val_rd_a <= reg_cell(to_integer(unsigned(addr_a)));
         end if;
         if (reset_a = '1') then -- Reset to Output 0 on A port
         val_rd_a <= (others => '0');
        end if;
     end if;
    end PROCESS PORT_A;
    
    --Port B operation process
     PORT_B: PROCESS (clk, reset_b, read_b, write_b)
    BEGIN 
    if rising_edge(clk) then
         if(write_b = '1') then --Write enable to B port 
            reg_cell(to_integer(unsigned(addr_b))) <= val_wr_b;
        end if;
         if(read_b = '1') then -- Read enable to B port
             val_rd_b <= reg_cell(to_integer(unsigned(addr_b)));
         end if;
         if (reset_b = '1') then -- Reset output to 0 on B port
         val_rd_b <= (others => '0');
        end if;
     end if;
    end PROCESS PORT_B;
    
end behav;
    
