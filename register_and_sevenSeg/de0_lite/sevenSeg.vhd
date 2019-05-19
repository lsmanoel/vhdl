library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSeg is
	generic (DISPLAY_MODE: std_logic := '0');
	port (DATA: in std_logic_vector (3 downto 0);
		  Q: out std_logic_vector (6 downto 0));
end entity;

architecture rtl of sevenSeg is
	type sevenSeg_out_array_logic_vector is array (9 downto 0) of std_logic_vector (6 downto 0);
	constant sevenSeg_tab: sevenSeg_out_array_logic_vector:=(
		0 => "1111110",
		1 => "0110000",
		2 => "1101101",
		3 => "1111001",
		4 => "0110011",
		5 => "1011011",
		6 => "1011111",
		7 => "1110000",
		8 => "1111111",
		9 => "1111011"
	);
begin
	Q <= sevenSeg_tab(to_integer(Unsigned(DATA))) when DISPLAY_MODE = '0' else
			not sevenSeg_tab(to_integer(Unsigned(DATA)));	
end;