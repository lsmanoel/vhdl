--mixerN3.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mixerN3 is
	generic (N:		integer);
	port (
		CLOCK: in std_logic;
		INPUT_0: in std_logic_vector (N-1 downto 0);
		INPUT_1: in std_logic_vector (N-1 downto 0);
		INPUT_2: in std_logic_vector (N-1 downto 0);
		Q: out std_logic_vector (N-1 downto 0)
	);
end entity;

architecture rtl of mixerN3 is

begin
	process(CLOCK)
	begin
		if CLOCK'event and CLOCK = '1' then
			Q <= INPUT_0 or INPUT_1 or INPUT_2;
		end if;
	end process;	
end;