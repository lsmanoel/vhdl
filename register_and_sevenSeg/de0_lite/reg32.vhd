library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg32 is
	port (
		CLOCK: 				in std_logic;
		DATA: 				in std_logic_vector (31 downto 0);
		ENABLE: 			in std_logic;
		Q:					out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of reg32 is
begin
	process(CLOCK)
	begin
		if (ENABLE = '1') then	
			if CLOCK'event and CLOCK = '1' then
				Q <= DATA;
			end if;
		end if;
	end process;
end;