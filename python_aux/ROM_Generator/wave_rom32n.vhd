library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.waveROM_package.all;

entity wave_rom32n is
	port (
		CLOCK: in std_logic;
		ADDRESS: in integer  range 0 to 1023;
		Q: out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of wave_rom32n is
begin
	process(CLOCK)
	begin
		if CLOCK'event and CLOCK = '1' then
			Q <= rom_core(ADDRESS);
		end if;
	end process;
end;

