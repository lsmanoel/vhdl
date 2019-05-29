-- rom3232.vhd

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom3232 is
	port (
		CLOCK: in std_logic;
		ADDRESS: in integer  range 0 to 31;
		Q: out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of rom3232 is
	type rom3232_out_array_logic_vector is array (31 downto 0) of std_logic_vector (31 downto 0);
	signal rom3232_rom_core: rom3232_out_array_logic_vector:=(
		0 	=> Std_logic_vector(To_unsigned( 0, 32)),
		1 	=> Std_logic_vector(To_unsigned( 1, 32)),
		2 	=> Std_logic_vector(To_unsigned( 2, 32)),
		3 	=> Std_logic_vector(To_unsigned( 3, 32)),
		4 	=> Std_logic_vector(To_unsigned( 5, 32)),
		5 	=> Std_logic_vector(To_unsigned( 8, 32)),
		6 	=> Std_logic_vector(To_unsigned( 13, 32)),
		7 	=> Std_logic_vector(To_unsigned( 21, 32)),
		8 	=> Std_logic_vector(To_unsigned( 34, 32)),
		9 	=> Std_logic_vector(To_unsigned( 55, 32)),
		10 	=> Std_logic_vector(To_unsigned( 89, 32)), -- A
		11 	=> Std_logic_vector(To_unsigned(144, 32)), -- B
		12 	=> Std_logic_vector(To_unsigned(233, 32)), -- C
		13 	=> Std_logic_vector(To_unsigned(377, 32)), -- D
		14 	=> Std_logic_vector(To_unsigned(610, 32)), -- E
		15 	=> Std_logic_vector(To_unsigned(987, 32)),  -- F
		others => Std_logic_vector(To_unsigned(0, 32))
	);
begin
	process(CLOCK)
	begin
		if CLOCK'event and CLOCK = '1' then
			Q <= rom3232_rom_core(ADDRESS);
		end if;
	end process;	
end;