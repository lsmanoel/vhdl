library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_hex2dig is
end entity;

architecture waveform of tb_hex2dig is
	-------------------------------------------------------------------
	-- CLOCK
	signal clock_50_0_logic, clock_50_PI_logic: std_logic;

	-----------------------------------------------------------------
	-- hex2dig
	component hex2dig is
		port(
			CLOCK: in std_logic;
			DATA: in std_logic_vector (31 downto 0);
			DIG0: out integer range 0 to 31;
			DIG1: out integer range 0 to 31;
			DIG2: out integer range 0 to 31;
			DIG3: out integer range 0 to 31;
			DIG4: out integer range 0 to 31;
			DIG5: out integer range 0 to 31
		);
	end component;

	signal data_integer: integer;
	signal data_unsigned: Unsigned (31 downto 0);
	signal data_logic_vector: std_logic_vector (31 downto 0);

	signal dig0_integer: integer range 0 to 31;
	signal dig0_unsigned: Unsigned (4 downto 0);
	signal dig0_logic_vector: std_logic_vector (4 downto 0);

	signal dig1_integer: integer range 0 to 31;
	signal dig1_unsigned: Unsigned (4 downto 0);
	signal dig1_logic_vector: std_logic_vector (4 downto 0);

	signal dig2_integer: integer range 0 to 31;
	signal dig2_unsigned: Unsigned (4 downto 0);
	signal dig2_logic_vector: std_logic_vector (4 downto 0);

	signal dig3_integer: integer range 0 to 31;
	signal dig3_unsigned: Unsigned (4 downto 0);
	signal dig3_logic_vector: std_logic_vector (4 downto 0);
	
	signal dig4_integer: integer range 0 to 31;
	signal dig4_unsigned: Unsigned (4 downto 0);
	signal dig4_logic_vector: std_logic_vector (4 downto 0);
	
	signal dig5_integer: integer range 0 to 31;
	signal dig5_unsigned: Unsigned (4 downto 0);
	signal dig5_logic_vector: std_logic_vector (4 downto 0);

	begin
	--===============================================================--
	-- CLOCK
	CLOCK_50_0: process -- 50 MHz phase 0
	begin
		clock_50_0_logic <= '1';
		wait for 10 ns;
		clock_50_0_logic <= '0';
		wait for 10 ns;
	end process;

	CLOCK_50_PI: process -- 50 MHz phase pi
	begin
		clock_50_PI_logic <= '0';
		wait for 10 ns;
		clock_50_PI_logic <= '1';
		wait for 10 ns;
	end process;

	--===============================================================--
	-- HEX2DIG
	hex2dig_vhd: hex2dig
	port map(
		CLOCK => clock_50_0_logic,
		DATA  => data_logic_vector,
		DIG0  => dig0_integer,
		DIG1  => dig1_integer,
		DIG2  => dig2_integer,
		DIG3  => dig3_integer,
		DIG4  => dig4_integer,
		DIG5  => dig5_integer);

	data_unsigned <= To_unsigned(data_integer, 32);
	data_logic_vector <= Std_logic_vector(data_unsigned);

	-- data_unsigned <= Unsigned(data_logic_vector);
	-- data_integer <= To_integer(data_unsigned);

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- HEX2DIG
	data_integer <= 123456;	
end architecture;