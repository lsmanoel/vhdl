-- sevenSegROM.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSegROM is
	port (
		CLOCK: in std_logic;
		DATA: in integer range 0 to 31;
		Q: buffer std_logic_vector (31 downto 0);
		notQ: out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of sevenSegROM is
	type sevenSegROM_out_array_logic_vector is array (31 downto 0) of std_logic_vector (31 downto 0);
	signal sevenSegROM_rom_core: sevenSegROM_out_array_logic_vector:=(
		0 	=> "00000000000000000000000011000000", -- 0
		1 	=> "00000000000000000000000011111001", -- 1
		2 	=> "00000000000000000000000010100100", -- 2
		3 	=> "00000000000000000000000010110000", -- 3
		4 	=> "00000000000000000000000010011001", -- 4
		5 	=> "00000000000000000000000010010010", -- 5
		6 	=> "00000000000000000000000010000010", -- 6
		7 	=> "00000000000000000000000011111000", -- 7
		8 	=> "00000000000000000000000010000000", -- 8
		9 	=> "00000000000000000000000010010000", -- 9
		10 	=> "00000000000000000000000010001000", -- A
		11 	=> "00000000000000000000000010000011", -- B
		12 	=> "00000000000000000000000010100111", -- C
		13 	=> "00000000000000000000000010100001", -- D
		14 	=> "00000000000000000000000010000110", -- E
		15 	=> "00000000000000000000000010001110", -- F
		others => "00000000000000000000000000000000"
	);
	
begin
	process(CLOCK)
	begin
		if CLOCK'event and CLOCK = '1' then
			Q <= sevenSegROM_rom_core(DATA);
		end if;
	end process;

	notQ <= not Q;	
end;