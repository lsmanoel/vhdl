library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg32n is
	generic (N:		integer);
	port (
		CLOCK: 				in std_logic;
		DATA: 				in std_logic_vector (31 downto 0);
		WRITE_ADDRESS: 		in integer range 0 to N-1;
		READ_ADDRESS: 		in integer range 0 to N-1;
		WE: 				in std_logic;
		Q:					out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of reg32n is
	type MEM is array (0 to N-1) of std_logic_vector(31 downto 0);
	signal reg32n_ram_core: MEM;
begin

	process(CLOCK)
	begin
		if (WE = '1') then	
			if CLOCK'event and CLOCK = '1' then
				Q <= reg32n_ram_core(READ_ADDRESS);
				reg32n_ram_core(WRITE_ADDRESS) <= DATA;
			end if;
		end if;
	end process;
	
end;