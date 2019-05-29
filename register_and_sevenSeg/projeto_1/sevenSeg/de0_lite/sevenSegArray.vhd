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
	-- INTEGER_2_DIGIT
	component int2dig is
	port(
		DATA: in integer;
		DIG0: out integer range 0 to 31;
		DIG1: out integer range 0 to 31;
		DIG2: out integer range 0 to 31;
		DIG3: out integer range 0 to 31;
		DIG4: out integer range 0 to 31;
		DIG5: out integer range 0 to 31
	);
	end component;

	type int2dig_dign_std_integer_array is array (N-1 downto 0) of integer range 0 to 31;
	type int2dig_dign_std_unsigned_array is array (N-1 downto 0) of Unsigned (4 downto 0);
	type int2dig_dign_std_logic_vector_array is array (N-1 downto 0) of std_logic_vector (4 downto 0);

	signal int2dig_data_integer: integer;
	signal int2dig_data_unsigned: Unsigned (31 downto 0);
	signal int2dig_data_logic_vector: Std_logic_vector (31 downto 0);

	signal int2dig_dign_integer_array: int2dig_dign_std_integer_array;
	signal int2dig_dign_unsigned_array: int2dig_dign_std_unsigned_array;
	signal int2dig_dign_logic_vector_array: int2dig_dign_std_logic_vector_array;


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

	type sevenSegROM_q_std_integer_array is array (N-1 downto 0) of integer;
	type sevenSegROM_q_std_unsigned_array is array (N-1 downto 0) of Unsigned (31 downto 0);
	type sevenSegROM_q_std_logic_vector_array is array (N-1 downto 0) of std_logic_vector (31 downto 0);

	signal sevenSegROM_clock_logic_vector: std_logic_vector (N-1 downto 0);

	signal sevenSegROM_data_integer_array: int2dig_dign_std_integer_array;
	signal sevenSegROM_data_unsigned_array: int2dig_dign_std_unsigned_array;
	signal sevenSegROM_data_logic_vector_array: int2dig_dign_std_logic_vector_array;

	signal sevenSegROM_q_integer_array: sevenSegROM_q_std_integer_array;
	signal sevenSegROM_q_unsigned_array: sevenSegROM_q_std_unsigned_array;
	signal sevenSegROM_q_logic_vector_array: sevenSegROM_q_std_logic_vector_array;

	signal sevenSegROM_notq_integer_array: sevenSegROM_q_std_integer_array;
	signal sevenSegROM_notq_unsigned_array: sevenSegROM_q_std_unsigned_array;
	signal sevenSegROM_notq_logic_vector_array: sevenSegROM_q_std_logic_vector_array;

begin
	--===============================================================--
	-- INTEGER_2_DIGIT
	int2dig_vhd: int2dig
		port map(
			DATA			=> int2dig_data_integer,
			DIG0			=> int2dig_dign_integer_array(0),
			DIG1			=> int2dig_dign_integer_array(1),
			DIG2			=> int2dig_dign_integer_array(2),
			DIG3			=> int2dig_dign_integer_array(3),
			DIG4			=> int2dig_dign_integer_array(4),
			DIG5			=> int2dig_dign_integer_array(5));

	
	int2dig_data_unsigned <= To_unsigned(int2dig_data_integer, 32);
	int2dig_data_logic_vector <= Std_logic_vector(int2dig_data_unsigned);

	int2dig_conversion: for i in N-1 downto 0 generate
		int2dig_dign_unsigned_array(i) <= Unsigned (int2dig_dign_logic_vector_array(i));
		int2dig_dign_integer_array(i) <= To_integer (int2dig_dign_unsigned_array(i));
	end generate int2dig_conversion;

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

		sevenSegROM_data_unsigned_array(i) <= Unsigned (sevenSegROM_data_logic_vector_array(i));
		sevenSegROM_data_integer_array(i) <= To_integer (sevenSegROM_data_unsigned_array(i));

		sevenSegROM_q_unsigned_array(i) <= Unsigned (sevenSegROM_q_logic_vector_array(i));
		sevenSegROM_q_integer_array(i) <= To_integer (sevenSegROM_q_unsigned_array(i));

		sevenSegROM_notq_unsigned_array(i) <= Unsigned (sevenSegROM_notq_logic_vector_array(i));
		sevenSegROM_notq_integer_array(i) <= To_integer (sevenSegROM_notq_unsigned_array(i));
	-------------------------------------------------------------------		
	end generate hex_display_array;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- INTEGER_2_DIGIT
	int2dig_data_integer <= 123456;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- SEVENSEGROM
	load_data_ctrl: for i in N-1 downto 0 generate
		sevenSegROM_clock_logic_vector(i) <= CLOCK;
	end generate load_data_ctrl;

	sevenSegROM_data_logic_vector_array <= int2dig_dign_logic_vector_array;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- HEXn
	HEX0 <= sevenSegROM_q_logic_vector_array(0)(7 downto 0);
	HEX1 <= sevenSegROM_q_logic_vector_array(1)(7 downto 0);
	HEX2 <= sevenSegROM_q_logic_vector_array(2)(7 downto 0);
	HEX3 <= sevenSegROM_q_logic_vector_array(3)(7 downto 0);
	HEX4 <= sevenSegROM_q_logic_vector_array(4)(7 downto 0);
	HEX5 <= sevenSegROM_q_logic_vector_array(5)(7 downto 0);

end architecture;

