----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 01:21:26 PM
-- Design Name: 
-- Module Name: TB_Nano_Processor - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Nano_Processor is
--  Port ( );
end TB_Nano_Processor;

architecture Behavioral of TB_Nano_Processor is

component Nano_Processor 
        Port (  Clk : in STD_LOGIC;
               Reset : in STD_LOGIC;
               SW  : in STD_LOGIC_VECTOR(3 downto 0);  -- Board switches
               BTN : in STD_LOGIC;                    -- Confirm button
               LED : out STD_LOGIC;                   -- LED for input ready
               Flags : out STD_LOGIC_VECTOR( 3 downto 0);
               Dis_LED : out STD_LOGIC_VECTOR (3 downto 0);
               Dis_7Seg : out STD_LOGIC_VECTOR (6 downto 0);
               Comparator_out : out STD_LOGIC_VECTOR (2 downto 0);
               AnodeSelector : out STD_LOGIC_VECTOR (3 downto 0)
              );
end component;

signal Clk : std_logic := '0';
signal Reset : std_logic;
signal Dis_LED, Flags, AnodeSelector : std_logic_vector (3 downto 0); 
signal Dis_7Seg : std_logic_vector (6 downto 0);
signal Comparator_out : std_logic_vector (2 downto 0);
signal SW : std_logic_vector(3 downto 0) := (others => '0');
signal BTN : std_logic := '0';
signal LED : std_logic := '0';
 
begin
    UUT : Nano_Processor 
        port map (
            Clk => Clk,
            Reset => Reset,
            Dis_LED => Dis_LED,
            Dis_7Seg => Dis_7Seg,
            Comparator_out => Comparator_out,
            Flags => Flags,
            SW => SW,
            BTN => BTN,
            LED => LED,
            AnodeSelector => AnodeSelector
         );

process begin 
    Clk <= not Clk;
    wait for 5 ns;
end process;

process begin 
    
     -- Initial reset
   Reset <= '1';
   SW <= "0000";
   BTN <= '0';
   wait for 100 ns;
   
   -- Release reset and prepare for load
   Reset <= '0';
   wait for 100 ns;
   
   -- Set switches and wait for LED indication (input ready)
   SW <= "0011"; -- Set desired input value
   wait until LED = '1'; -- Wait for processor to be ready for input
   wait for 20 ns; -- Small delay for signal stability
   
   -- Press confirm button
   BTN <= '1';
   wait for 40 ns; -- Hold button for adequate time
   BTN <= '0';
   
   -- Let program continue
   wait for 500 ns;
   
   -- End test
   Reset <= '1';
   wait;
end process;       

end Behavioral;
