library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSeg is
	generic (DISPLAY_MODE: std_logic := '0');
	port (
		CLOCK: in std_logic;
		DOT: in std_logic;
		DATA: in std_logic_vector (3 downto 0);
		Q: out std_logic_vector (7 downto 0)
	);
end entity;

architecture rtl of sevenSeg is
	type sevenSeg_out_array_logic_vector is array (15 downto 0) of std_logic_vector (7 downto 0);
	constant sevenSeg_tab: sevenSeg_out_array_logic_vector:=(
		0 	=> "11111100",
		1 	=> "01100000",
		2 	=> "11011010",
		3 	=> "11110010",
		4 	=> "01100110",
		5 	=> "10110110",
		6 	=> "10111110",
		7 	=> "11100000",
		8 	=> "11111110",
		9 	=> "11110110",
		10 	=> "11101110", -- A
		11 	=> "00111110", -- B
		12 	=> "10011100", -- C
		13 	=> "01111010", -- D
		14 	=> "00011110", -- E
		15 	=> "10001110"  -- F
	);
begin
	process(CLOCK)
	begin
		if CLOCK'event and CLOCK = '1' then
			if DISPLAY_MODE = '1' then
				if DOT = '1' then
					Q <= sevenSeg_tab(to_integer(Unsigned(DATA))) or "00000001";
				else
					Q <= sevenSeg_tab(to_integer(Unsigned(DATA)));
				end if;
			else
				if DOT = '1' then
					Q <= not sevenSeg_tab(to_integer(Unsigned(DATA))) or "00000001";
				else
					Q <= not sevenSeg_tab(to_integer(Unsigned(DATA)));
				end if;
			end if;
		end if;
	end process;	
end;