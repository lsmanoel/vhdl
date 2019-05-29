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
	sevenSegArray_clock_logic <= MAX10_CLK1_50;
	sevenSegArray_data_integer <= 123456;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- HEXn
	HEX0 <= sevenSegArray_HEX0_logic_vector;
	HEX1 <= sevenSegArray_HEX1_logic_vector;
	HEX2 <= sevenSegArray_HEX2_logic_vector;
	HEX3 <= sevenSegArray_HEX3_logic_vector;
	HEX4 <= sevenSegArray_HEX4_logic_vector;
	HEX5 <= sevenSegArray_HEX5_logic_vector;

end;


