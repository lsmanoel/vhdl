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
	-- WAVE_ROM32n
	component wave_rom32n is
		port (
			CLOCK: in std_logic;
			ADDRESS: integer  range 0 to 31;
			Q: out std_logic_vector (31 downto 0)
		);
	end component;

	signal wave_rom32n_clock_logic: std_logic;

	signal wave_rom32n_address_integer: integer range 0 to 255;
	signal wave_rom32n_address_unsigned: Unsigned(7 downto 0);
	signal wave_rom32n_address_logic_vector: std_logic_vector(7 downto 0);

	signal wave_rom32n_q_integer: integer;
	signal wave_rom32n_q_unsigned: Unsigned (31 downto 0);
	signal wave_rom32n_q_logic_vector: std_logic_vector (31 downto 0);

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
	wave_rom32n_vhd: wave_rom32n
			port map (
				CLOCK => wave_rom32n_clock_logic,
				ADDRESS => wave_rom32n_address_integer,
				Q => wave_rom32n_q_logic_vector);


	wave_rom32n_address_unsigned <= Unsigned (wave_rom32n_address_logic_vector);
	wave_rom32n_address_integer <= To_integer (wave_rom32n_address_unsigned);

	wave_rom32n_q_unsigned <= Unsigned (wave_rom32n_q_logic_vector);
	wave_rom32n_q_integer <= To_integer (wave_rom32n_q_unsigned);

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

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- SEVENSEGROM
	load_data_ctrl: for i in 5 downto 0 generate
		sevenSegROM_clock_logic_vector(i) <= MAX10_CLK1_50;
		sevenSeg_dot_logic_vector(i) <= '0';
	end generate load_data_ctrl;

	sevenSegROM_data_logic_vector_array(0) <= 
	sevenSegROM_data_logic_vector_array(1) <= 
	sevenSegROM_data_logic_vector_array(2) <= 
	sevenSegROM_data_logic_vector_array(3) <= 
	sevenSegROM_data_logic_vector_array(4) <= 
	sevenSegROM_data_logic_vector_array(5) <= 

	HEX0 <= sevenSegROM_q_logic_vector_array(0)(7 downto 0);
	HEX1 <= sevenSegROM_q_logic_vector_array(1)(7 downto 0);
	HEX2 <= sevenSegROM_q_logic_vector_array(2)(7 downto 0);
	HEX3 <= sevenSegROM_q_logic_vector_array(3)(7 downto 0);
	HEX4 <= sevenSegROM_q_logic_vector_array(4)(7 downto 0);
	HEX5 <= sevenSegROM_q_logic_vector_array(5)(7 downto 0);

end;


