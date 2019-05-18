library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSeg is
	generic (display_mode: std_logic := '0');
	port (seg_in: in std_logic_vector (3 downto 0);
		  seg_out: out std_logic_vector (6 downto 0));
end entity;

architecture rtl of sevenSeg is
	type seven_seg_tab is array (9 downto 0) of std_logic_vector (6 downto 0);
	constant seven_seg_tab_1: seven_seg_tab:=(
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
	seg_out <= seven_seg_tab_1(to_integer(Unsigned(seg_in))) when display_mode = '0' else
			   not seven_seg_tab_1(to_integer(Unsigned(seg_in)));	
end;