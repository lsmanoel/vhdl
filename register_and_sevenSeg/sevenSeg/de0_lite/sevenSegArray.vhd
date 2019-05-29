library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSegArray is
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
end entity;

architecture waveform of sevenSegArray is
	-------------------------------------------------------------------
	-- HEX2DIG
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

	signal hex2dig_clock_logic: std_logic;

	signal hex2dig_data_integer: integer;
	signal hex2dig_data_unsigned: Unsigned (31 downto 0);
	signal hex2dig_data_logic_vector: std_logic_vector (31 downto 0);

	signal hex2dig_dig0_integer: integer range 0 to 31;
	signal hex2dig_dig0_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig0_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig1_integer: integer range 0 to 31;
	signal hex2dig_dig1_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig1_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig2_integer: integer range 0 to 31;
	signal hex2dig_dig2_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig2_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig3_integer: integer range 0 to 31;
	signal hex2dig_dig3_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig3_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig4_integer: integer range 0 to 31;
	signal hex2dig_dig4_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig4_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig5_integer: integer range 0 to 31;
	signal hex2dig_dig5_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig5_logic_vector: std_logic_vector (4 downto 0);	

	-------------------------------------------------------------------
	-- SEVENSEGROM
	component sevenSegROM is
		port (
			CLOCK: in std_logic;
			DATA: in integer range 0 to 31;
			Q: out std_logic_vector (31 downto 0);
			notQ: out std_logic_vector (31 downto 0)
		);	
	end component;

	type sevenSegROM_data_std_integer_array is array (N-1 downto 0) of integer  range 0 to 31;
	type sevenSegROM_data_std_unsigned_array is array (N-1 downto 0) of Unsigned (4 downto 0);
	type sevenSegROM_data_std_logic_vector_array is array (N-1 downto 0) of std_logic_vector (4 downto 0);

	type sevenSegROM_q_std_integer_array is array (N-1 downto 0) of integer;
	type sevenSegROM_q_std_unsigned_array is array (N-1 downto 0) of Unsigned (31 downto 0);
	type sevenSegROM_q_std_logic_vector_array is array (N-1 downto 0) of std_logic_vector (31 downto 0);

	signal sevenSegROM_clock_logic_vector: std_logic_vector (N-1 downto 0);

	signal sevenSegROM_data_integer_array: sevenSegROM_data_std_integer_array;
	signal sevenSegROM_data_unsigned_array: sevenSegROM_data_std_unsigned_array;
	signal sevenSegROM_data_logic_vector_array: sevenSegROM_data_std_logic_vector_array;

	signal sevenSegROM_q_integer_array: sevenSegROM_q_std_integer_array;
	signal sevenSegROM_q_unsigned_array: sevenSegROM_q_std_unsigned_array;
	signal sevenSegROM_q_logic_vector_array: sevenSegROM_q_std_logic_vector_array;

	signal sevenSegROM_notq_integer_array: sevenSegROM_q_std_integer_array;
	signal sevenSegROM_notq_unsigned_array: sevenSegROM_q_std_unsigned_array;
	signal sevenSegROM_notq_logic_vector_array: sevenSegROM_q_std_logic_vector_array;

begin
	--===============================================================--
	-- HEX2DIG
	hex2dig_vhd: hex2dig
		port map(
			CLOCK 			=> hex2dig_clock_logic,
			DATA			=> hex2dig_data_logic_vector,
			DIG0			=> hex2dig_dig0_integer,
			DIG1			=> hex2dig_dig1_integer,
			DIG2			=> hex2dig_dig2_integer,
			DIG3			=> hex2dig_dig3_integer,
			DIG4			=> hex2dig_dig4_integer,
			DIG5			=> hex2dig_dig5_integer);

	
	hex2dig_data_unsigned <= To_unsigned(hex2dig_data_integer, 32);
	hex2dig_data_logic_vector <= Std_logic_vector(hex2dig_data_unsigned);

	hex2dig_dig0_unsigned <= To_unsigned (hex2dig_dig0_integer, 5);
	hex2dig_dig0_logic_vector <= Std_logic_vector (hex2dig_dig0_unsigned);

	hex2dig_dig1_unsigned <= To_unsigned (hex2dig_dig1_integer, 5);
	hex2dig_dig1_logic_vector <= Std_logic_vector (hex2dig_dig1_unsigned);

	hex2dig_dig2_unsigned <= To_unsigned (hex2dig_dig2_integer, 5);
	hex2dig_dig2_logic_vector <= Std_logic_vector (hex2dig_dig2_unsigned);


	hex2dig_dig3_unsigned <= To_unsigned (hex2dig_dig3_integer, 5);
	hex2dig_dig3_logic_vector <= Std_logic_vector (hex2dig_dig3_unsigned);


	hex2dig_dig4_unsigned <= To_unsigned (hex2dig_dig4_integer, 5);
	hex2dig_dig4_logic_vector <= Std_logic_vector (hex2dig_dig4_unsigned);


	hex2dig_dig5_unsigned <= To_unsigned (hex2dig_dig5_integer, 5);
	hex2dig_dig5_logic_vector <= Std_logic_vector (hex2dig_dig5_unsigned);

	--===============================================================--
	-- SEVENSEGROM
	hex_display_array: for i in N-1 downto 0 generate 
	-------------------------------------------------------------------
		sevenSegROM_vhd: sevenSegROM 	
				port map (
					CLOCK 					=> sevenSegROM_clock_logic_vector(i),
					DATA 					=> sevenSegROM_data_integer_array(i),
					Q 						=> sevenSegROM_q_logic_vector_array(i),
					notQ 					=> sevenSegROM_notq_logic_vector_array(i));

		sevenSegROM_data_unsigned_array(i) <= To_unsigned(sevenSegROM_data_integer_array(i), 5);
		sevenSegROM_data_logic_vector_array(i) <= Std_logic_vector(sevenSegROM_data_unsigned_array(i));

		sevenSegROM_q_unsigned_array(i) <= Unsigned (sevenSegROM_q_logic_vector_array(i));
		sevenSegROM_q_integer_array(i) <= To_integer (sevenSegROM_q_unsigned_array(i));

		sevenSegROM_notq_unsigned_array(i) <= Unsigned (sevenSegROM_notq_logic_vector_array(i));
		sevenSegROM_notq_integer_array(i) <= To_integer (sevenSegROM_notq_unsigned_array(i));
	-------------------------------------------------------------------		
	end generate hex_display_array;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- HEX2DIG
	hex2dig_clock_logic <= CLOCK;
	hex2dig_data_integer <= DATA;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- SEVENSEGROM
	load_data_ctrl: for i in N-1 downto 0 generate
		sevenSegROM_clock_logic_vector(i) <= CLOCK;
	end generate load_data_ctrl;

	sevenSegROM_data_integer_array(0) <= hex2dig_dig0_integer;
	sevenSegROM_data_integer_array(1) <= hex2dig_dig1_integer;
	sevenSegROM_data_integer_array(2) <= hex2dig_dig2_integer;
	sevenSegROM_data_integer_array(3) <= hex2dig_dig3_integer;
	sevenSegROM_data_integer_array(4) <= hex2dig_dig4_integer;
	sevenSegROM_data_integer_array(5) <= hex2dig_dig5_integer;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- HEXn
	HEX0 <= sevenSegROM_q_logic_vector_array(0)(7 downto 0);
	HEX1 <= sevenSegROM_q_logic_vector_array(1)(7 downto 0);
	HEX2 <= sevenSegROM_q_logic_vector_array(2)(7 downto 0);
	HEX3 <= sevenSegROM_q_logic_vector_array(3)(7 downto 0);
	HEX4 <= sevenSegROM_q_logic_vector_array(4)(7 downto 0);
	HEX5 <= sevenSegROM_q_logic_vector_array(5)(7 downto 0);

end architecture;

