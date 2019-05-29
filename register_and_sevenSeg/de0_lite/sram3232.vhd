library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sram3232 is
	port (
		CLOCK: 				in std_logic;
		DATA: 				in std_logic_vector 	(31 downto 0);
		WRITE_ADDRESS: 		in integer range 0 to 31;
		READ_ADDRESS: 		in integer range 0 to 31;
		WE: 				in std_logic;
		Q:					out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of sram3232 is
	type MEM is array (0 to 31) of std_logic_vector(31 downto 0);
	signal sram3232_ram_core: MEM;
begin

	process(CLOCK)
	begin	
		if CLOCK'event and CLOCK = '1' then
			if (WE = '1') then
				Q <= sram3232_ram_core(READ_ADDRESS);
				sram3232_ram_core(WRITE_ADDRESS) <= DATA;
			end if;
		end if;
	end process;
	
end;