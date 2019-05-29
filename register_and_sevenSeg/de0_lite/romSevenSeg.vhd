-- romSevenSeg.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity romSevenSeg is
	generic (DISPLAY_MODE: std_logic := '0');
	port (
		CLOCK: in std_logic;
		DATA: in integer range 0 to 31;
		Q: buffer std_logic_vector (31 downto 0);
		notQ: out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of romSevenSeg is
	type romSevenSeg_out_array_logic_vector is array (31 downto 0) of std_logic_vector (31 downto 0);
	signal romSevenSeg_rom_core: romSevenSeg_out_array_logic_vector:=(
		0 	=> "00000000000000000000000001111110",
		1 	=> "00000000000000000000000000110000",
		2 	=> "00000000000000000000000001101101",
		3 	=> "00000000000000000000000001111001",
		4 	=> "00000000000000000000000000110011",
		5 	=> "00000000000000000000000001011011",
		6 	=> "00000000000000000000000001011111",
		7 	=> "00000000000000000000000001110000",
		8 	=> "00000000000000000000000001111111",
		9 	=> "00000000000000000000000001111011",
		10 	=> "00000000000000000000000001110111", -- A
		11 	=> "00000000000000000000000000011111", -- B
		12 	=> "00000000000000000000000001001110", -- C
		13 	=> "00000000000000000000000000111101", -- D
		14 	=> "00000000000000000000000000001111", -- E
		15 	=> "00000000000000000000000001000111",  -- F
		others => "00000000000000000000000000000000"
	);
	
begin
	process(CLOCK)
	begin
		if CLOCK'event and CLOCK = '1' then
			Q <= romSevenSeg_rom_core(DATA);
		end if;
	end process;

	notQ <= not Q;	
end;