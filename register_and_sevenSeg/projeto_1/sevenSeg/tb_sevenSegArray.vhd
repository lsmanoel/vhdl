library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_sevenSegArray is
end entity;

architecture waveform of tb_sevenSegArray is
	-------------------------------------------------------------------
	-- CLOCK
	signal clock_50_0_logic, clock_50_PI_logic: std_logic;

	-------------------------------------------------------------------
	-- SW
	signal SW: std_logic_vector(9 downto 0);

	-------------------------------------------------------------------
	-- HEXn
	signal HEX0: std_logic_vector(7 downto 0);
	signal HEX1: std_logic_vector(7 downto 0);
	signal HEX2: std_logic_vector(7 downto 0);
	signal HEX3: std_logic_vector(7 downto 0);
	signal HEX4: std_logic_vector(7 downto 0);
	signal HEX5: std_logic_vector(7 downto 0);

	-------------------------------------------------------------------
	-- SEVENSEGROM
	component sevenSegArray is
		generic (N: integer := 6);
		port (
			CLOCK: in std_logic;
			DATA: in integer;	
			HEX0: out std_logic_vector(7 downto 0);
			HEX1: out std_logic_vector(7 downto 0);
			HEX2: out std_logic_vector(7 downto 0);
			HEX3: out std_logic_vector(7 downto 0);
			HEX4: out std_logic_vector(7 downto 0);
			HEX5: out std_logic_vector(7 downto 0)
		);
	end component;

	constant N_DISPLAY: integer := 6;

	signal sevenSegArray_clock_logic: std_logic;

	signal sevenSegArray_data_integer: integer;
	signal sevenSegArray_data_unsigned: Unsigned(31 downto 0);
	signal sevenSegArray_data_logic_vector: std_logic_vector (31 downto 0);


	signal sevenSegArray_HEX0_integer: integer range 0 to 255;
	signal sevenSegArray_HEX0_unsigned: Unsigned (7 downto 0);
	signal sevenSegArray_HEX0_logic_vector: std_logic_vector(7 downto 0);

	signal sevenSegArray_HEX1_integer: integer range 0 to 255;
	signal sevenSegArray_HEX1_unsigned: Unsigned (7 downto 0);
	signal sevenSegArray_HEX1_logic_vector: std_logic_vector(7 downto 0);

	signal sevenSegArray_HEX2_integer: integer range 0 to 255;
	signal sevenSegArray_HEX2_unsigned: Unsigned (7 downto 0);
	signal sevenSegArray_HEX2_logic_vector: std_logic_vector(7 downto 0);

	signal sevenSegArray_HEX3_integer: integer range 0 to 255;
	signal sevenSegArray_HEX3_unsigned: Unsigned (7 downto 0);
	signal sevenSegArray_HEX3_logic_vector: std_logic_vector(7 downto 0);

	signal sevenSegArray_HEX4_integer: integer range 0 to 255;
	signal sevenSegArray_HEX4_unsigned: Unsigned (7 downto 0);
	signal sevenSegArray_HEX4_logic_vector: std_logic_vector(7 downto 0);

	signal sevenSegArray_HEX5_integer: integer range 0 to 255;
	signal sevenSegArray_HEX5_unsigned: Unsigned (7 downto 0);
	signal sevenSegArray_HEX5_logic_vector: std_logic_vector(7 downto 0);


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
	-- SW

	--===============================================================--
	-- SEVENSEGARRAY
	sevenSegArray_vhd: sevenSegArray 	
			port map (
				CLOCK => sevenSegArray_clock_logic,
				DATA => sevenSegArray_data_integer,
				HEX0 => sevenSegArray_HEX0_logic_vector,
				HEX1 => sevenSegArray_HEX1_logic_vector,
				HEX2 => sevenSegArray_HEX2_logic_vector,
				HEX3 => sevenSegArray_HEX3_logic_vector,
				HEX4 => sevenSegArray_HEX4_logic_vector,
				HEX5 => sevenSegArray_HEX5_logic_vector);

	sevenSegArray_data_unsigned <= To_unsigned (sevenSegArray_data_integer, 32);
	sevenSegArray_data_logic_vector <= Std_logic_vector (sevenSegArray_data_unsigned);

	sevenSegArray_HEX0_unsigned <= Unsigned (sevenSegArray_HEX0_logic_vector);
	sevenSegArray_HEX0_integer <= To_integer (sevenSegArray_HEX0_unsigned);

	sevenSegArray_HEX1_unsigned <= Unsigned (sevenSegArray_HEX1_logic_vector);
	sevenSegArray_HEX1_integer <= To_integer (sevenSegArray_HEX1_unsigned);

	sevenSegArray_HEX2_unsigned <= Unsigned (sevenSegArray_HEX2_logic_vector);
	sevenSegArray_HEX2_integer <= To_integer (sevenSegArray_HEX2_unsigned);

	sevenSegArray_HEX3_unsigned <= Unsigned (sevenSegArray_HEX3_logic_vector);
	sevenSegArray_HEX3_integer <= To_integer (sevenSegArray_HEX3_unsigned);

	sevenSegArray_HEX4_unsigned <= Unsigned (sevenSegArray_HEX4_logic_vector);
	sevenSegArray_HEX4_integer <= To_integer (sevenSegArray_HEX4_unsigned);

	sevenSegArray_HEX5_unsigned <= Unsigned (sevenSegArray_HEX5_logic_vector);
	sevenSegArray_HEX5_integer <= To_integer (sevenSegArray_HEX5_unsigned);


	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- SEVENSEGARRAY	
	sevenSegArray_clock_logic <= clock_50_0_logic;
	sevenSegArray_data_integer <= 123456;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- HEXn
	HEX0 <= sevenSegArray_HEX0_logic_vector;
	HEX1 <= sevenSegArray_HEX1_logic_vector;
	HEX2 <= sevenSegArray_HEX2_logic_vector;
	HEX3 <= sevenSegArray_HEX3_logic_vector;
	HEX4 <= sevenSegArray_HEX4_logic_vector;
	HEX5 <= sevenSegArray_HEX5_logic_vector;

end architecture;