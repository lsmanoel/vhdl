library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_reg3232 is
end entity;

architecture waveform of tb_reg3232 is
	-------------------------------------------------------------------
	-- CLOCK
	signal clock_50_0_logic, clock_50_PI_logic: std_logic;

	-------------------------------------------------------------------
	-- DATA
	signal data_integer: integer;
	signal data_logic_unsigned: Unsigned (31 downto 0);
	signal data_logic_vector: std_logic_vector (31 downto 0);

	-------------------------------------------------------------------
	-- WR_ADDRESS
	signal w_address_integer: integer range 0 to 31;
	signal r_address_integer: integer range 0 to 31;
	signal wr_address_logic_unsigned: Unsigned (9 downto 0);
	signal wr_address_logic_vector: std_logic_vector (9 downto 0);

	-------------------------------------------------------------------
	-- WE
	signal we_logic: std_logic;

	-------------------------------------------------------------------
	-- Q
	signal q_integer: integer;
	signal q_logic_unsigned: Unsigned (31 downto 0);
	signal q_logic_vector: std_logic_vector (31 downto 0);

	-------------------------------------------------------------------
	-- REG3232
	component reg3232 is
		port 	(CLOCK: 				in std_logic;
				 DATA: 					in std_logic_vector (31 downto 0);
				 WRITE_ADDRESS: 		in integer range 0 to 31;
				 READ_ADDRESS: 			in integer range 0 to 31;
				 WE: 					in std_logic;
				 Q:						out std_logic_vector (31 downto 0));
	end component;

	signal reg3232_clock_logic: std_logic;
	signal reg3232_we_logic: std_logic;

	signal reg3232_data_unsigned: Unsigned(31 downto 0);
	signal reg3232_data_logic_vector: std_logic_vector (31 downto 0);

	signal reg3232_write_address_integer: integer range 0 to 31;
	signal reg3232_write_address_unsigned: Unsigned(31 downto 0);
	signal reg3232_write_address_logic_vector: std_logic_vector(31 downto 0);

	signal reg3232_read_address_integer: integer range 0 to 31;
	signal reg3232_read_address_unsigned: Unsigned(31 downto 0);
	signal reg3232_read_address_logic_vector: std_logic_vector (31 downto 0);

	signal reg3232_q_unsigned: Unsigned(31 downto 0);
	signal reg3232_q_logic_vector: std_logic_vector (31 downto 0);

begin
	--===============================================================--
	-- CLOCK
	-- 50 MHz phase 0
	CLOCK_50_0: process
	begin
		clock_50_0_logic <= '1';
		wait for 10 ns;
		clock_50_0_logic <= '0';
		wait for 10 ns;
	end process;

	-- 50 MHz phase pi
	CLOCK_50_PI: process
	begin
		clock_50_PI_logic <= '0';
		wait for 10 ns;
		clock_50_PI_logic <= '1';
		wait for 10 ns;
	end process;

	--===============================================================--
	WR_ADDRESS: process
	begin
		w_address_integer <= w_address_integer + 1;
		r_address_integer <= r_address_integer + 1;
		wait for 10 ns;
	end process;
	
	wr_address_logic_unsigned <= To_unsigned(w_address_integer, 5)&To_unsigned(r_address_integer, 5);	
	wr_address_logic_vector	<= Std_logic_vector(wr_address_logic_unsigned);

	--===============================================================--
	WE: process
	begin
		we_logic <= '0';
		wait for 10 ns;
		we_logic <= '1';
		wait for 10 ns;
	end process;
	
	--===============================================================--
	-- DATA
	data_integer <= 10;

	data_logic_unsigned <= To_unsigned(data_integer, 32);	
	data_logic_vector	<= Std_logic_vector(data_logic_unsigned);
	--===============================================================--
	-- Q
	q_logic_unsigned <= Unsigned(q_logic_vector);
	q_integer <= To_integer(q_logic_unsigned);

	--===============================================================--
	reg3232_vhd: reg3232
			port map (
				CLOCK 					=> reg3232_clock_logic,
				DATA 					=> reg3232_data_logic_vector,
				WRITE_ADDRESS 			=> reg3232_write_address_integer,
				READ_ADDRESS 			=> reg3232_read_address_integer,
				WE 						=> reg3232_we_logic,
				Q 						=> reg3232_q_logic_vector);

	reg3232_clock_logic <= clock_50_0_logic;
	reg3232_data_logic_vector <= data_logic_vector; 
	reg3232_write_address_integer <= w_address_integer;
	reg3232_read_address_integer <= r_address_integer;
	reg3232_we_logic <= we_logic;
	q_logic_vector <= reg3232_q_logic_vector;



end architecture;