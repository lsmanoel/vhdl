library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSeg is
    generic (DISPLAY_MODE:		std_logic);
	port 	(SEG_IN:			in std_logic_vector (3  downto 0);
	 		 SEG_OUT:			out std_logic_vector (7 downto 0);
	 		 LOAD_DATA:			in std_logic);  
end entity;

architecture rtl of sevenSeg is
	type seven_seg_tab 				is array (31 downto 0) of unsigned(7 downto 0);

	signal seven_seg_tab_1: seven_seg_tab:=(
		0		=> "11111100",
		1		=> "01100000",
		2		=> "11011010",
		3		=> "11110010",
		4		=> "01100110",
		5		=> "10110110",
		6		=> "10111110",
		7		=> "11100000",
		8		=> "11111110",
		9		=> "11110110",
		10		=> "11101110",
		11		=> "00111110",
		12		=> "10011110",
		13		=> "10011100",
		14		=> "01111100",
		15		=> "10001110",
		others 	=> "00000000"
	);

begin

	process(LOAD_DATA)
	begin
		if LOAD_DATA'event and LOAD_DATA = '1' then
			if DISPLAY_MODE = '0' then
				SEG_OUT <= 		Std_logic_vector(seven_seg_tab_1(to_integer(Unsigned(SEG_IN))));
			else		
				SEG_OUT <= 	not Std_logic_vector(seven_seg_tab_1(to_integer(Unsigned(SEG_IN))));
			end if;			
		end if;
	end process;

--	process(LOAD_DATA)
--	begin
--		if LOAD_DATA'event and LOAD_DATA = '1' then
--			SEG_OUT <= 		Std_logic_vector(seven_seg_tab_1(to_integer(Unsigned(SEG_IN))));
--		end if;
--	end process;
end;