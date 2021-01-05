----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/12/02 00:30:53
-- Design Name: 
-- Module Name: Test_Bench - Behavioral
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

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Behavioral of Test_Bench is
component calculator_top is
Port( 
    SYS_RESET_B           : in std_logic;
    SYS_CLK               : in std_Logic;

    START                 : in std_logic;
    OP_CODE               : in std_logic_vector(2 downto 0);

    DATA_A                : in std_logic_vector(7 downto 0);
    DATA_B                : in std_logic_vector(7 downto 0);

    DATA_C                : out std_logic_vector(15 downto 0);
    END_OP                : out std_logic);
end component;

signal SYS_CLK: std_logic:= '0';
signal SYS_RESET: std_logic:= '0';
signal START: std_logic:= '0';
signal OP_CODE: std_logic_vector(2 downto 0):= (others => '0');
signal DATA_A: std_logic_vector(7 downto 0):= (others => '0');
signal DATA_B: std_logic_vector(7 downto 0):= (others => '0');
signal DATA_C: std_logic_vector(15 downto 0);
signal END_OP: std_logic;


constant SYS_CLK_period : time  := 10ns;

begin
    UUT : calculator_top port map(
        SYS_RESET_B => SYS_RESET, 
        START => START,
        OP_CODE => OP_CODE,
        SYS_CLK => SYS_CLK, 
        DATA_A => DATA_A, 
        DATA_B => DATA_B, 
        DATA_C => DATA_C,
        END_OP => END_OP);
    clk_process : process
    begin
        SYS_CLK <= '0';
        wait for SYS_CLK_period/2;
        SYS_CLK <= '1';
        wait for SYS_CLK_period/2;
    end process;
    
    stim_proc: process
    begin
        wait for 100 ns;
            SYS_RESET <= '1';
            
            

        wait for SYS_CLK_period * 5;
            START <= '1';
            DATA_A <= "11111101";
            DATA_B <= "11111011";
            OP_CODE <= "001";   --mul
            
        wait for SYS_CLK_period * 20;
            START <= '0';
            DATA_A <= x"05";
            DATA_B <= x"03";
            OP_CODE <= "010";   --substract


       wait for SYS_CLK_period * 5;
            START <= '1';
            DATA_A <= x"06";
            DATA_B <= x"03";
            OP_CODE <= "100";  
            
--        wait for SYS_CLK_period * 20;

--            DATA_A <= "11111111";   -- "3"
--            DATA_B <= "11111111";   -- "13"
--            OP_CODE <= "100";  -- "x"     ==> 00001111 (15)       
            
--        wait for SYS_CLK_period * 20;
--            DATA_A <= "00001100";   -- "12"
--            DATA_B <= "00001100";   -- "12"
--            OP_CODE <= "100";  -- "x"     ==> 00001111 (15) 
            
--        wait for SYS_CLK_period * 20;
--            DATA_A <=x"03";   -- "12"
--            DATA_B <= "11111011";  -- "12"
--            OP_CODE <= "100";  -- "x"     ==> 00001111 (15) 
        wait;
     end process;



end Behavioral;
