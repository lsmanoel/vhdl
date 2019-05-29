library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSeg is
	generic (DISPLAY_MODE: std_logic := '0');
	port (
		CLOCK: in std_logic;
		DOT: in std_logic;
		DATA: in integer range 0 to 31;
		Q: out std_logic_vector (7 downto 0)
	);
end entity;

architecture rtl of sevenSeg is
	type sevenSeg_out_array_logic_vector is array (31 downto 0) of std_logic_vector (7 downto 0);
	signal sevenSeg_rom_core: sevenSeg_out_array_logic_vector:=(
		0 	=> "01111110",
		1 	=> "00110000",
		2 	=> "01101101",
		3 	=> "01111001",
		4 	=> "00110011",
		5 	=> "01011011",
		6 	=> "01011111",
		7 	=> "01110000",
		8 	=> "01111111",
		9 	=> "01111011",
		10 	=> "01110111", -- A
		11 	=> "00011111", -- B
		12 	=> "01001110", -- C
		13 	=> "00111101", -- D
		14 	=> "00001111", -- E
		15 	=> "01000111",  -- F
		others => "00000000"
	);
begin
	process(CLOCK)
	begin
		if CLOCK'event and CLOCK = '1' then
			if DISPLAY_MODE = '1' then
				if DOT = '1' then
					Q <= sevenSeg_rom_core(DATA) or "10000000";
				else
					Q <= sevenSeg_rom_core(DATA);
				end if;
			else
				if DOT = '1' then
					Q <= not sevenSeg_rom_core(DATA) or "10000000";
				else
					Q <= not sevenSeg_rom_core(DATA);
				end if;
			end if;
		end if;
	end process;	
end;