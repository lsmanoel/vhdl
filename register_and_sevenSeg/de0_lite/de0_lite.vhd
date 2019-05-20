-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : Lucas Seara Manoel
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Projeto base DE10-Lite
-- License MIT
-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity de0_lite is 
	port (
		---------- CLOCK ----------
		ADC_CLK_10:			in std_logic;
		MAX10_CLK1_50:		in std_logic;
		MAX10_CLK2_50:		in std_logic;
		
		----------- SDRAM ------------
		DRAM_ADDR:	 		out std_logic_vector (12 downto 0);
		DRAM_BA:	 		out std_logic_vector (1 downto 0);
		DRAM_CAS_N:	 		out std_logic;
		DRAM_CKE:	 		out std_logic;
		DRAM_CLK:	 		out std_logic;
		DRAM_CS_N:	 		out std_logic;		
		DRAM_DQ:	 		inout std_logic_vector(15 downto 0);
		DRAM_LDQM:	 		out std_logic;
		DRAM_RAS_N:	 		out std_logic;
		DRAM_UDQM:	 		out std_logic;
		RAM_WE_N:	 		out std_logic;
		
		----------- SEG7 ------------
		HEX0:		 		out std_logic_vector(7 downto 0);
		HEX1:		 		out std_logic_vector(7 downto 0);
		HEX2:		 		out std_logic_vector(7 downto 0);
		HEX3:		 		out std_logic_vector(7 downto 0);
		HEX4:		 		out std_logic_vector(7 downto 0);
		HEX5:		 		out std_logic_vector(7 downto 0);

		----------- KEY ------------
		KEY: 				in std_logic_vector(1 downto 0);

		----------- LED ------------
		LEDR: 				out std_logic_vector(9 downto 0);

		----------- SW ------------
		SW: 				in std_logic_vector(9 downto 0);

		----------- VGA ------------
		VGA_B:				out std_logic_vector(3 downto 0);
		VGA_G:				out std_logic_vector(3 downto 0);
		VGA_HS:				out std_logic;
		VGA_R:				out std_logic_vector(3 downto 0);
		VGA_VS:				out std_logic;
	
		----------- Accelerometer ------------
		GSENSOR_CS_N:		out std_logic;
		GSENSOR_INT:		in std_logic_vector(2 downto 1);
		GSENSOR_SCLK:		out std_logic;
		GSENSOR_SDI:		inout std_logic;
		GSENSOR_SDO:		inout std_logic;
	
		----------- Arduino ------------
		ARDUINO_IO:			inout std_logic_vector(15 downto 0);
		ARDUINO_RESET_N:	inout std_logic
	);
end entity;
architecture rtl of de0_lite is
	-------------------------------------------------------------------
	-- REG3232
	component reg3232 is
		port (
			CLOCK: in std_logic;
			DATA: in std_logic_vector (31 downto 0);
			WRITE_ADDRESS: in integer range 0 to 31;
			READ_ADDRESS: in integer range 0 to 31;
			WE: in std_logic;
			Q:	out std_logic_vector (31 downto 0)
		);
	end component;

	signal reg3232_clock_logic: std_logic;

	signal reg3232_data_integer: integer;
	signal reg3232_data_unsigned: Unsigned (31 downto 0);
	signal reg3232_data_logic_vector: std_logic_vector (31 downto 0);

	signal reg3232_write_address_integer: integer range 0 to 31;
	signal reg3232_write_address_unsigned: Unsigned (4 downto 0);
	signal reg3232_write_address_logic_vector: std_logic_vector(4 downto 0);

	signal reg3232_read_address_integer: integer range 0 to 31;
	signal reg3232_read_address_unsigned: Unsigned (4 downto 0);
	signal reg3232_read_address_logic_vector: std_logic_vector (4 downto 0);
	
	signal reg3232_we_logic: std_logic;

	signal reg3232_q_integer: integer;
	signal reg3232_q_unsigned: Unsigned (31 downto 0);
	signal reg3232_q_logic_vector: std_logic_vector (31 downto 0);

	-------------------------------------------------------------------
	-- REG32n
	component reg32n is
		generic (N: integer);
		port (
			CLOCK: in std_logic;
			DATA: in std_logic_vector (31 downto 0);
			WRITE_ADDRESS: in integer range 0 to N-1;
			READ_ADDRESS: in integer range 0 to N-1;
			WE: in std_logic;
			Q:	out std_logic_vector (31 downto 0)
		);
	end component;

	constant reg32n_n_const_integer: integer := 32;

	signal reg32n_clock_logic: std_logic;

	signal reg32n_data_integer: integer;
	signal reg32n_data_unsigned: Unsigned (31 downto 0);
	signal reg32n_data_logic_vector: std_logic_vector (31 downto 0);

	signal reg32n_write_address_integer: integer range 0 to reg32n_n_const_integer;
	signal reg32n_write_address_unsigned: Unsigned (4 downto 0);
	signal reg32n_write_address_logic_vector: std_logic_vector(4 downto 0);

	signal reg32n_read_address_integer: integer range 0 to reg32n_n_const_integer;
	signal reg32n_read_address_unsigned: Unsigned (4 downto 0);
	signal reg32n_read_address_logic_vector: std_logic_vector (4 downto 0);
	
	signal reg32n_we_logic: std_logic;

	signal reg32n_q_integer: integer;
	signal reg32n_q_unsigned: Unsigned (31 downto 0);
	signal reg32n_q_logic_vector: std_logic_vector (31 downto 0);
	
	-------------------------------------------------------------------
	-- SEVENSEG
	component sevenSeg is
		generic (DISPLAY_MODE: std_logic);
		port (
			CLOCK: in std_logic;
			DOT: in std_logic;
			DATA: in std_logic_vector (3 downto 0);
			Q: out std_logic_vector (7 downto 0));  	
	end component;

	type sevenSeg_data_std_integer_array is array (5 downto 0) of integer range 0 to 15;
	type sevenSeg_data_std_unsigned_array is array (5 downto 0) of Unsigned (3 downto 0);
	type sevenSeg_data_std_logic_vector_array is array (5 downto 0) of std_logic_vector (3 downto 0);

	type sevenSeg_q_std_integer_array is array (5 downto 0) of integer range 0 to 255;
	type sevenSeg_q_std_unsigned_array is array (5 downto 0) of Unsigned (7 downto 0);
	type sevenSeg_q_std_logic_vector_array is array (5 downto 0) of std_logic_vector (7 downto 0);

	constant sevenSeg_display_mode_const_logic: std_logic := '0';

	signal sevenSeg_clock_logic_vector: std_logic_vector (5 downto 0);

	signal sevenSeg_dot_logic_vector: std_logic_vector (5 downto 0);

	signal sevenSeg_data_integer_array: sevenSeg_data_std_integer_array;
	signal sevenSeg_data_unsigned_array: sevenSeg_data_std_unsigned_array;
	signal sevenSeg_data_logic_vector_array: sevenSeg_data_std_logic_vector_array;

	signal sevenSeg_q_integer_array: sevenSeg_q_std_integer_array;
	signal sevenSeg_q_unsigned_array: sevenSeg_q_std_unsigned_array;
	signal sevenSeg_q_logic_vector_array: sevenSeg_q_std_logic_vector_array;

	signal test_012345_input: sevenSeg_data_std_logic_vector_array:=(
		0		=> "0000",
		1		=> "0001",
		2		=> "0010",
		3		=> "0011",
		4		=> "0100",
		5		=> "0101");

begin
	--===============================================================--
	reg3232_vhd: reg3232
			port map (
				CLOCK 					=> reg3232_clock_logic,
				DATA 					=> reg3232_data_logic_vector,
				WRITE_ADDRESS 			=> reg3232_write_address_integer,
				READ_ADDRESS 			=> reg3232_read_address_integer,
				WE 						=> reg3232_we_logic,
				Q 						=> reg3232_q_logic_vector);

	reg3232_data_unsigned <= Unsigned (reg3232_data_logic_vector);
	reg3232_data_integer <= To_integer (reg3232_data_unsigned);

	reg3232_read_address_unsigned <= Unsigned(reg3232_read_address_logic_vector);
	reg3232_read_address_integer <= To_integer(reg3232_read_address_unsigned);
	
	reg3232_write_address_unsigned <= Unsigned(reg3232_write_address_logic_vector);
	reg3232_write_address_integer <= To_integer(reg3232_write_address_unsigned);

	reg3232_q_unsigned <= Unsigned(reg3232_q_logic_vector);
	reg3232_q_integer <= To_integer(reg3232_q_unsigned);

	--===============================================================--
	reg32n_vhd: reg32n
			generic map (
				N						=> 32)
			port map (
				CLOCK 					=> reg32n_clock_logic,
				DATA 					=> reg32n_data_logic_vector,
				WRITE_ADDRESS 			=> reg32n_write_address_integer,
				READ_ADDRESS 			=> reg32n_read_address_integer,
				WE 						=> reg32n_we_logic,
				Q 						=> reg32n_q_logic_vector);

	reg32n_data_unsigned <= Unsigned (reg32n_data_logic_vector);
	reg32n_data_integer <= To_integer (reg32n_data_unsigned);

	reg32n_read_address_unsigned <= Unsigned(reg32n_read_address_logic_vector);
	reg32n_read_address_integer <= To_integer(reg32n_read_address_unsigned);
	
	reg32n_write_address_unsigned <= Unsigned(reg32n_write_address_logic_vector);
	reg32n_write_address_integer <= To_integer(reg32n_write_address_unsigned);

	reg32n_q_unsigned <= Unsigned(reg32n_q_logic_vector);
	reg32n_q_integer <= To_integer(reg32n_q_unsigned);

	--===============================================================--
	hex_display_array: for i in 5 downto 0 generate 
	-------------------------------------------------------------------
	sevenSeg_vhd: sevenSeg 	
		generic map (
			DISPLAY_MODE 		=> sevenSeg_display_mode_const_logic)
		port map (
			CLOCK 				=> sevenSeg_clock_logic_vector(i),
			DOT 				=> sevenSeg_dot_logic_vector(i),
			DATA 				=> sevenSeg_data_logic_vector_array(i),
			Q 					=> sevenSeg_q_logic_vector_array(i));

	sevenSeg_data_unsigned_array(i) <= Unsigned (sevenSeg_data_logic_vector_array(i));
	sevenSeg_data_integer_array(i) <= To_integer (sevenSeg_data_unsigned_array(i));

	sevenSeg_q_unsigned_array(i) <= Unsigned (sevenSeg_q_logic_vector_array(i));
	sevenSeg_q_integer_array(i) <= To_integer (sevenSeg_q_unsigned_array(i));
	-------------------------------------------------------------------		
	end generate hex_display_array;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- REG3232
	reg3232_clock_logic <= MAX10_CLK1_50;

	reg3232_data_logic_vector(3 downto 0) <= SW(3 downto 0); 
	reg3232_data_logic_vector(31 downto 4) <= (others => '0');

	reg3232_write_address_logic_vector <= SW(8 downto 4);

	reg3232_read_address_logic_vector <= SW(8 downto 4);
	
	reg3232_we_logic <= SW(9);

	
	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- REG32n
	reg32n_clock_logic <= MAX10_CLK1_50;

	reg32n_data_logic_vector(3 downto 0) <= SW(3 downto 0); 
	reg32n_data_logic_vector(31 downto 4) <= (others => '0');

	reg32n_write_address_logic_vector <= SW(8 downto 4);

	reg32n_read_address_logic_vector <= SW(8 downto 4);
	
	reg32n_we_logic <= SW(9);

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- SEVENSEG
	load_data_ctrl: for i in 5 downto 0 generate
		sevenSeg_clock_logic_vector(i) <= MAX10_CLK1_50;

		sevenSeg_dot_logic_vector(i) <= '1';
	end generate load_data_ctrl;

	sevenSeg_data_logic_vector_array(0) <= reg3232_q_logic_vector(3 downto 0);
	sevenSeg_data_logic_vector_array(1) <= reg32n_q_logic_vector(3 downto 0);

	HEX0 <= sevenSeg_q_logic_vector_array(0);
	HEX1 <= sevenSeg_q_logic_vector_array(1);
	HEX2 <= sevenSeg_q_logic_vector_array(2);
	HEX3 <= sevenSeg_q_logic_vector_array(3);
	HEX4 <= sevenSeg_q_logic_vector_array(4);
	HEX5 <= sevenSeg_q_logic_vector_array(5);

end;


