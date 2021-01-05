----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2020/12/02 00:33:00
-- Design Name: 
-- Module Name: Binary_Adder_Substractor_8bit - Behavioral
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

entity Binary_Adder_Substractor_8bit is
    Port ( a : in STD_LOGIC_VECTOR (15 downto 0);
           b : in STD_LOGIC_VECTOR (15 downto 0);
           oper : in STD_LOGIC;
           result : out STD_LOGIC_VECTOR (15 downto 0));
end Binary_Adder_Substractor_8bit;

architecture Behavioral of Binary_Adder_Substractor_8bit is
component Full_Adder is 
    Port(
    x: in std_logic;
    y: in std_logic;
    cin: in std_logic;
    s: out std_logic;
    cout: out std_logic);
end component;
 

-- oper∞° 0 ¿Ã∏È µ°º¿, 1 ¿Ã∏È ª¨º¿ 
signal c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, over, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16 : std_logic;

begin

b1 <= b(0) xor oper;
b2 <= b(1) xor oper;
b3 <= b(2) xor oper;
b4 <= b(3) xor oper;
b5 <= b(4) xor oper;
b6 <= b(5) xor oper;
b7 <= b(6) xor oper;
b8 <= b(7) xor oper;
b9 <= b(8) xor oper;
b10 <= b(9) xor oper;
b11 <= b(10) xor oper;
b12 <= b(11) xor oper;
b13 <= b(12) xor oper;
b14 <= b(13) xor oper;
b15 <= b(14) xor oper;
b16 <= b(15) xor oper;

F1:  Full_Adder port map(x => a(0), y => b1, cin => oper, s => result(0), cout => c1);
F2:  Full_Adder port map(x => a(1), y => b2, cin => c1, s => result(1), cout => c2);
F3:  Full_Adder port map(x => a(2), y => b3, cin => c2, s => result(2), cout => c3);
F4:  Full_Adder port map(x => a(3), y => b4, cin => c3, s => result(3), cout => c4);
F5:  Full_Adder port map(x => a(4), y => b5, cin => c4, s => result(4), cout => c5);
F6:  Full_Adder port map(x => a(5), y => b6, cin => c5, s => result(5), cout => c6);
F7:  Full_Adder port map(x => a(6), y => b7, cin => c6, s => result(6), cout => c7);
F8:  Full_Adder port map(x => a(7), y => b8, cin => c7, s => result(7), cout => c8);
F9:  Full_Adder port map(x => a(8), y => b9, cin => c8, s => result(8), cout => c9);
F10: Full_Adder port map(x => a(9), y => b10, cin => c9, s => result(9), cout => c10);
F11: Full_Adder port map(x => a(10), y => b11, cin => c10, s => result(10), cout => c11);
F12: Full_Adder port map(x => a(11), y => b12, cin => c11, s => result(11), cout => c12);
F13: Full_Adder port map(x => a(12), y => b13, cin => c12, s => result(12), cout => c13);
F14: Full_Adder port map(x => a(13), y => b14, cin => c13, s => result(13), cout => c14);
F15: Full_Adder port map(x => a(14), y => b15, cin => c14, s => result(14), cout => c15);
F16: Full_Adder port map(x => a(15), y => b16, cin => c15, s => result(15), cout => over);




end Behavioral;
