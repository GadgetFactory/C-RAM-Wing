----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:47:58 04/08/2011 
-- Design Name: 
-- Module Name:    cram_wing - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cram_wing is
    Port ( address : out  STD_LOGIC_VECTOR (17 downto 0);
           data : inout  STD_LOGIC_VECTOR (15 downto 0);
           ncs : out  STD_LOGIC;
           nwe : out  STD_LOGIC;
           noe : out  STD_LOGIC;
           nble : out  STD_LOGIC;
           nbhe : out  STD_LOGIC;
           sump_read : in  STD_LOGIC;
           sump_write : in  STD_LOGIC;
           sump_clk : in  STD_LOGIC;
           sump_data : inout  STD_LOGIC_VECTOR (12 downto 0));
end cram_wing;

architecture Behavioral of cram_wing is

signal addra : std_logic_vector (17 downto 0) := (others => '0');

begin
	nble <= '0';
	nbhe <= '0';
	ncs <= '0';
	noe <= '0';
	
	sump_data <= data(12 downto 0) when sump_read = '1' else (others => 'Z');
	data(12 downto 0) <= sump_data when sump_write = '1' else (others => 'Z');
	
	address <= addra;

	nwe <= not sump_write;

	-- memory address controller
	process(sump_clk)
	begin
		if rising_edge(sump_clk) then
			if sump_write = '1' then
				if addra >= (256*1024) - 1 then
					addra <= (others => '0');
				else
					addra <= addra + 1;
				end if;
			elsif sump_read = '1' then
				if addra = "0" then
					addra <= std_logic_vector(to_unsigned((256*1024) - 1, addra'length));
				else
					addra <= addra - 1;
				end if;
			end if;
		end if;
	end process;

end Behavioral;

