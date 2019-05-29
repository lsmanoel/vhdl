library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_sevenSegROM is
end entity;

architecture waveform of tb_sevenSegROM is
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
	component sevenSegROM is
		port (
			CLOCK: in std_logic;
			DATA: in integer range 0 to 31;
			Q: out std_logic_vector (31 downto 0);
			notQ: out std_logic_vector (31 downto 0)
		);	
	end component;

	constant N_DISPLAY: integer := 6;
	type sevenSegROM_data_std_integer_array is array (N_DISPLAY-1 downto 0) of integer range 0 to 31;
	type sevenSegROM_data_std_unsigned_array is array (N_DISPLAY-1 downto 0) of Unsigned (4 downto 0);
	type sevenSegROM_data_std_logic_vector_array is array (N_DISPLAY-1 downto 0) of std_logic_vector (4 downto 0);

	type sevenSegROM_q_std_integer_array is array (N_DISPLAY-1 downto 0) of integer;
	type sevenSegROM_q_std_unsigned_array is array (N_DISPLAY-1 downto 0) of Unsigned (31 downto 0);
	type sevenSegROM_q_std_logic_vector_array is array (N_DISPLAY-1 downto 0) of std_logic_vector (31 downto 0);

	signal sevenSegROM_clock_logic_vector: std_logic_vector (N_DISPLAY-1 downto 0);

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
	SW <= Std_logic_vector(To_unsigned(0, 10));

	--===============================================================--
	-- SEVENSEGROM

	--===============================================================--
	hex_display_array: for i in N_DISPLAY-1 downto 0 generate 
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
	-- SEVENSEGROM
	load_data_ctrl: for i in 5 downto 0 generate
		sevenSegROM_clock_logic_vector(i) <= clock_50_0_logic;
	end generate load_data_ctrl;

	sevenSegROM_data_logic_vector_array(0) <= SW(4 downto 0);
	sevenSegROM_data_logic_vector_array(1) <= SW(9 downto 5);
	sevenSegROM_data_logic_vector_array(2) <= Std_logic_vector(To_unsigned(2, 5));
	sevenSegROM_data_logic_vector_array(3) <= Std_logic_vector(To_unsigned(3, 5));
	sevenSegROM_data_logic_vector_array(4) <= Std_logic_vector(To_unsigned(4, 5));
	sevenSegROM_data_logic_vector_array(5) <= Std_logic_vector(To_unsigned(5, 5));

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- HEXn
	HEX0 <= sevenSegROM_q_logic_vector_array(0)(7 downto 0);
	HEX1 <= sevenSegROM_q_logic_vector_array(1)(7 downto 0);
	HEX2 <= sevenSegROM_q_logic_vector_array(2)(7 downto 0);
	HEX3 <= sevenSegROM_q_logic_vector_array(3)(7 downto 0);
	HEX4 <= sevenSegROM_q_logic_vector_array(4)(7 downto 0);
	HEX5 <= sevenSegROM_q_logic_vector_array(5)(7 downto 0);

end architecture;