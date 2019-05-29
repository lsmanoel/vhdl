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
	-- ROM3232
	component trigTabROM32n is
		port (
			CLOCK: in std_logic;
			ADDRESS: integer  range 0 to 31;
			Q: out std_logic_vector (31 downto 0);
			notQ: out std_logic_vector (31 downto 0)
		);
	end component;

	signal rom3232_clock_logic: std_logic;

	signal rom3232_address_integer: integer range 0 to 255;
	signal rom3232_address_unsigned: Unsigned(7 downto 0);
	signal rom3232_address_logic_vector: std_logic_vector(7 downto 0);

	signal rom3232_q_integer: integer;
	signal rom3232_q_unsigned: Unsigned (31 downto 0);
	signal rom3232_q_logic_vector: std_logic_vector (31 downto 0);


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

	type sevenSegROM_data_std_integer_array is array (5 downto 0) of integer range 0 to 31;
	type sevenSegROM_data_std_unsigned_array is array (5 downto 0) of Unsigned (4 downto 0);
	type sevenSegROM_data_std_logic_vector_array is array (5 downto 0) of std_logic_vector (4 downto 0);

	type sevenSegROM_q_std_integer_array is array (5 downto 0) of integer range 0 to 255;
	type sevenSegROM_q_std_unsigned_array is array (5 downto 0) of Unsigned (31 downto 0);
	type sevenSegROM_q_std_logic_vector_array is array (5 downto 0) of std_logic_vector (31 downto 0);

	signal sevenSegROM_clock_logic_vector: std_logic_vector (5 downto 0);

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
	rom3232_vhd: rom3232
			port map (
				CLOCK => rom3232_clock_logic,
				ADDRESS => rom3232_address_integer,
				Q => rom3232_q_logic_vector);


	rom3232_address_unsigned <= Unsigned (rom3232_address_logic_vector);
	rom3232_address_integer <= To_integer (rom3232_address_unsigned);

	rom3232_q_unsigned <= Unsigned (rom3232_q_logic_vector);
	rom3232_q_integer <= To_integer (rom3232_q_unsigned);

	--===============================================================--
	sync_rom_vhd: sync_rom
			port map (
				CLOCK => sync_rom_clock_logic,
				ADDRESS => sync_rom_address_logic_vector,
				DATA_OUT => sync_rom_data_out_logic_vector);


	sync_rom_address_unsigned <= Unsigned (sync_rom_address_logic_vector);
	sync_rom_address_integer <= To_integer (sync_rom_address_unsigned);

	sync_rom_data_out_unsigned <= Unsigned (sync_rom_data_out_logic_vector);
	sync_rom_data_out_integer <= To_integer (sync_rom_data_out_unsigned);

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

	----===============================================================--
	--hex_display_array: for i in 5 downto 0 generate 
	---------------------------------------------------------------------
	--sevenSeg_vhd: sevenSeg 	
	--	generic map (
	--		DISPLAY_MODE 		=> sevenSeg_display_mode_const_logic)
	--	port map (
	--		CLOCK 				=> sevenSeg_clock_logic_vector(i),
	--		DOT 				=> sevenSeg_dot_logic_vector(i),
	--		DATA 				=> sevenSeg_data_integer_array(i),
	--		Q 					=> sevenSeg_q_logic_vector_array(i));

	--sevenSeg_data_unsigned_array(i) <= Unsigned (sevenSeg_data_logic_vector_array(i));
	--sevenSeg_data_integer_array(i) <= To_integer (sevenSeg_data_unsigned_array(i));

	--sevenSeg_q_unsigned_array(i) <= Unsigned (sevenSeg_q_logic_vector_array(i));
	--sevenSeg_q_integer_array(i) <= To_integer (sevenSeg_q_unsigned_array(i));
	---------------------------------------------------------------------		
	--end generate hex_display_array;

	--===============================================================--
	-- MIXERN2
	mixerN2_vhd: mixerN2
			generic map(
				N 				=> mixerN2_N_const_integer)
			port map (
				CLOCK 			=> mixerN2_clock_logic,
				INPUT_0 		=> mixerN2_input_0_logic_vector,
				INPUT_1 		=> mixerN2_input_1_logic_vector,
				Q 				=> mixerN2_q_logic_vector);


	mixerN2_input_0_unsigned <= Unsigned (mixerN2_input_0_logic_vector);
	mixerN2_input_0_integer <= To_integer (mixerN2_input_0_unsigned);

	mixerN2_input_1_unsigned <= Unsigned (mixerN2_input_1_logic_vector);
	mixerN2_input_1_integer <= To_integer (mixerN2_input_1_unsigned);

	mixerN2_q_unsigned <= Unsigned (mixerN2_q_logic_vector);
	mixerN2_q_integer <= To_integer (mixerN2_q_unsigned);

	--===============================================================--
	-- MIXERN3
	mixerN3_vhd: mixerN3
			generic map(
				N 				=> mixerN3_N_const_integer)
			port map (
				CLOCK 			=> mixerN3_clock_logic,
				INPUT_0 		=> mixerN3_input_0_logic_vector,
				INPUT_1 		=> mixerN3_input_1_logic_vector,
				INPUT_2 		=> mixerN3_input_2_logic_vector,
				Q 				=> mixerN3_q_logic_vector);


	mixerN3_input_0_unsigned <= Unsigned (mixerN3_input_0_logic_vector);
	mixerN3_input_0_integer <= To_integer (mixerN3_input_0_unsigned);

	mixerN3_input_1_unsigned <= Unsigned (mixerN3_input_1_logic_vector);
	mixerN3_input_1_integer <= To_integer (mixerN3_input_1_unsigned);

	mixerN3_input_2_unsigned <= Unsigned (mixerN3_input_2_logic_vector);
	mixerN3_input_2_integer <= To_integer (mixerN3_input_2_unsigned);

	mixerN3_q_unsigned <= Unsigned (mixerN3_q_logic_vector);
	mixerN3_q_integer <= To_integer (mixerN3_q_unsigned);

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- ROM3232
	rom3232_clock_logic <= MAX10_CLK1_50;

	rom3232_address_logic_vector <= SW(7 downto 0);

	

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- SYNC_ROM
	sync_rom_clock_logic <= MAX10_CLK1_50;

	sync_rom_address_logic_vector <= SW(7 downto 0);

	

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
	-- SEVENSEGROM
	load_data_ctrl: for i in 5 downto 0 generate
		sevenSegROM_clock_logic_vector(i) <= MAX10_CLK1_50;

		sevenSeg_dot_logic_vector(i) <= SW(9);
	end generate load_data_ctrl;

	sevenSegROM_data_logic_vector_array(0) <= reg3232_q_logic_vector(4 downto 0);
	sevenSegROM_data_logic_vector_array(1) <= reg32n_q_logic_vector(4 downto 0);

	HEX0 <= sevenSegROM_q_logic_vector_array(0)(7 downto 0);
	HEX1 <= sevenSegROM_q_logic_vector_array(1)(7 downto 0);
	HEX2 <= sevenSegROM_q_logic_vector_array(2)(7 downto 0);
	HEX3 <= sevenSegROM_q_logic_vector_array(3)(7 downto 0);
	HEX4 <= sevenSegROM_q_logic_vector_array(4)(7 downto 0);
	HEX5 <= sevenSegROM_q_logic_vector_array(5)(7 downto 0);

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- MIXERN2
	mixerN2_clock_logic <= MAX10_CLK1_50;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- MIXERN3
	mixerN3_clock_logic <= MAX10_CLK1_50;
	mixerN3_input_0_logic_vector <= rom3232_q_logic_vector(mixerN3_N_const_integer-1 downto 0);
	mixerN3_input_1_logic_vector(5 downto 0) <= sync_rom_data_out_logic_vector(5 downto 0);
	mixerN3_input_2_logic_vector <= mixerN2_q_logic_vector;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- LEDR
	LEDR <= mixerN3_q_logic_vector;

end;


