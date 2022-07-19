----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2022 02:45:41 PM
-- Design Name: 
-- Module Name: pe_control - finite
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.numeric_std.ALL;
USE work.rs_df_config.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pe_control is
 Port ( 
        clk: in std_logic;
        data_av: in std_logic_vector(1 DOWNTO 0);
        write_m1: out std_logic;
        write_m2: out std_logic;
        write_a: out std_logic;
        read: out std_logic;
        reset: out std_logic;
        flush: out std_logic;
        addr_m1: out std_logic_vector(rf_sel-1 DOWNTO 0);
        addr_m2: out std_logic_vector(rf_sel-1 DOWNTO 0);
        addr_a: out std_logic_vector(rf_sel-1 DOWNTO 0)
 
 );
end pe_control;

architecture finite of pe_control is
type statetype is (idle,load, load_sr, comp, flushing);
signal cur_state, nx_state : statetype := idle;
signal offset : integer := 0;
signal win_count : integer := 0;
constant win_size : integer := 3;

begin
state_space: process (data_av, win_count, cur_state)
begin
case cur_state is
    when idle => 
        if data_av = "01" then
            nx_state <= load;
        elsif data_av = "10" then
            nx_state <= load_sr;
        else    
           nx_state <= idle;
        end if;
    when load => 
        if (win_count + 1)  = win_size then
            nx_state <= comp;
        else 
            nx_state <= load;
        end if;
    when comp => 
        if (win_count + 1) = win_size then
            nx_state <= flushing;
        else 
            nx_state <= comp;        
        end if;
     when flushing => 
        if data_av = "01" then 
            nx_state <= load;
        elsif data_av = "10" then
            nx_state <= load_sr;
        else 
           nx_state <= idle;
        end if;
      when load_sr => 
            nx_state <= comp;
     end case;
  end process state_space;

clocked_change: process(clk) 
begin
    if rising_edge(clk) then
    cur_state <= nx_state;
    end if;
    
read <= '0' WHEN (cur_state = idle or cur_state = load or cur_state = load_sr) else '1';
reset <= '1' WHEN (cur_state = idle or cur_state = load or cur_state = load_sr) else '0';
write_m1 <= '1' WHEN (cur_state = load) else '0';
write_m2 <= '1' WHEN (cur_state = load or cur_state = load_sr) else '0';
write_a <= '1' WHEN (cur_state = comp or cur_state= flushing) else '0';
addr_m1 <= std_logic_vector(to_unsigned(win_count,addr_m2'length));
addr_m2 <= std_logic_vector(to_unsigned((win_count + offset),addr_m2'length));
addr_a <= (others => '0');
end process clocked_change;

unclocked_change : process(clk, win_count, cur_state, nx_state)
begin
 if (rising_edge(clk)) then
 if ((cur_state = load and nx_state=load) or (cur_state = comp and nx_state = comp)) then
        win_count <= win_count + 1;
 elsif((cur_state = load and nx_state=comp) or (cur_state = load_sr and nx_state = comp)) then
        win_count <= 0;
 elsif (cur_state = comp and nx_state=flushing) then
        offset <= offset + 1; 
 elsif (cur_state = idle and nx_state = load) then
    offset <= 0; 
 end if; 
 if  (cur_state = flushing) then
       flush <= '1';
 else
       flush <= '0';
 end if;
 end if;
end process unclocked_change;

end finite;
