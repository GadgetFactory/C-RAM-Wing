--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:48:59 04/08/2011
-- Design Name:   
-- Module Name:   C:/dbdev/My Dropbox/GadgetFactory/Sump_Blaze_Core/scripts/CRAM_Wing_ISE/cram_wing_tb.vhd
-- Project Name:  CRAM_Wing_ISE
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cram_wing
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cram_wing_tb IS
END cram_wing_tb;
 
ARCHITECTURE behavior OF cram_wing_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cram_wing
    PORT(
         address : OUT  std_logic_vector(17 downto 0);
         data : INOUT  std_logic_vector(15 downto 0);
         ncs : OUT  std_logic;
         nwe : OUT  std_logic;
         noe : OUT  std_logic;
         nble : OUT  std_logic;
         nbhe : OUT  std_logic;
         sump_read : IN  std_logic;
         sump_write : IN  std_logic;
         sump_clk : IN  std_logic;
         sump_data : INOUT  std_logic_vector(12 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal sump_read : std_logic := '0';
   signal sump_write : std_logic := '0';
   signal sump_clk : std_logic := '0';

	--BiDirs
   signal data : std_logic_vector(15 downto 0);
   signal sump_data : std_logic_vector(12 downto 0);

 	--Outputs
   signal address : std_logic_vector(17 downto 0);
   signal ncs : std_logic;
   signal nwe : std_logic;
   signal noe : std_logic;
   signal nble : std_logic;
   signal nbhe : std_logic;

   -- Clock period definitions
   constant sump_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cram_wing PORT MAP (
          address => address,
          data => data,
          ncs => ncs,
          nwe => nwe,
          noe => noe,
          nble => nble,
          nbhe => nbhe,
          sump_read => sump_read,
          sump_write => sump_write,
          sump_clk => sump_clk,
          sump_data => sump_data
        );

   -- Clock process definitions
   sump_clk_process :process
   begin
		sump_clk <= '0';
		wait for sump_clk_period/2;
		sump_clk <= '1';
		wait for sump_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for sump_clk_period*10;

      -- insert stimulus here 
		sump_data <= "1010101010101";
		data <= "1111111111111111";
		wait for sump_clk_period/2;
		sump_write <= '1';
		wait for sump_clk_period/2;
		sump_write <= '0';
		sump_data <= "ZZZZZZZZZZZZZ";
		wait for sump_clk_period/2;
		sump_read <= '1';
		wait for sump_clk_period/2;
		sump_read <= '0';

      wait;
   end process;

END;
