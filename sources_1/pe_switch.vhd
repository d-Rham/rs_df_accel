library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
--USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pe_switch is
 generic(
 sel : integer := 2;
 size : integer := 8
 );
 Port ( 
        dir_sel: IN std_logic_vector(sel-1 DOWNTO 0);
        data_in: IN std_logic_vector(size-1 DOWNTO 0);
        data_ver: out std_logic_vector(size-1 DOWNTO 0);
        data_hor: out std_logic_vector(size-1 DOWNTO 0);
 
 );
end pe_control;                       

architecture 
