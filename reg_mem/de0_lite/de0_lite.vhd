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
	component reg32n is
		generic (N:		integer);
		port 	(CLOCK: 				in std_logic;
				 DATA: 					in std_logic_vector (31 downto 0);
				 WRITE_ADDRESS: 		in integer range 0 to 31;
				 READ_ADDRESS: 			in integer range 0 to 31;
				 WE: 					in std_logic;
				 Q:						out std_logic_vector (31 downto 0));
	end component;

	signal reg32n_clock: std_logic;
	signal reg32n_we: std_logic;

	signal reg32n_data_unsigned: Unsigned(31 downto 0);
	signal reg32n_data_logic_vector: std_logic_vector (31 downto 0);

	signal reg32n_write_address_integer: integer range 0 to 31;
	signal reg32n_write_address_unsigned: Unsigned(31 downto 0);
	signal reg32n_write_address_logic_vector: std_logic_vector(31 downto 0);

	signal reg32n_read_address_integer: integer range 0 to 31;
	signal reg32n_read_address_unsigned: Unsigned(31 downto 0);
	signal reg32n_read_address_logic_vector: std_logic_vector (31 downto 0);

	signal reg32n_q_unsigned: Unsigned(31 downto 0);
	signal reg32n_q_logic_vector: std_logic_vector (31 downto 0);
	
	-------------------------------------------------------------------	
	component sevenSeg is
	    generic (DISPLAY_MODE:			std_logic);
		port 	(SEG_IN:				in std_logic_vector (3 downto 0);
		 		 SEG_OUT:				out std_logic_vector (7 downto 0);
		 		 LOAD_DATA:				in std_logic);   	
	end component;

	type seven_seg_input_array is array (5 downto 0) of std_logic_vector(3 downto 0);
	type seven_seg_output_array is array (5 downto 0) of std_logic_vector(7 downto 0);
	type seven_seg_load_array is array (5 downto 0) of std_logic;

	constant sevenSeg_displayMode: std_logic := '0';
	signal sevenSeg_seg_in: seven_seg_input_array;
	signal sevenSeg_seg_out: seven_seg_output_array;
	signal sevenSeg_load_data: seven_seg_load_array;

	signal test_012345_input: seven_seg_input_array:=(
		0		=> "0000",
		1		=> "0001",
		2		=> "0010",
		3		=> "0011",
		4		=> "0100",
		5		=> "0101");

begin
	--===============================================================--
	reg32n_vhd: reg32n
			generic map (
				N						=> 32)
			port map (
				CLOCK 					=> MAX10_CLK1_50,
				DATA 					=> reg32n_data_logic_vector,
				WRITE_ADDRESS 			=> reg32n_write_address_integer,
				READ_ADDRESS 			=> reg32n_read_address_integer,
				WE 						=> reg32n_we,
				Q 						=> reg32n_q_logic_vector);

	reg32n_clock <= MAX10_CLK1_50;

	reg32n_data_logic_vector(3 downto 0) <= SW(3 downto 0); 
	reg32n_data_logic_vector(31 downto 4) <= (others => '0');

	reg32n_we <= SW(8);

	reg32n_read_address_logic_vector(3 downto 0) <= SW(7 downto 4);
	reg32n_read_address_logic_vector(31 downto 4) <= (others => '0');

	reg32n_read_address_unsigned <= Unsigned(reg32n_read_address_logic_vector);
	reg32n_read_address_integer <= To_integer(reg32n_read_address_unsigned);

	reg32n_write_address_logic_vector(3 downto 0) <= SW(7 downto 4);
	reg32n_write_address_logic_vector(31 downto 4) <= (others => '0');
	
	reg32n_write_address_unsigned <= Unsigned(reg32n_write_address_logic_vector);
	reg32n_write_address_integer <= To_integer(reg32n_write_address_unsigned);

	reg32n_q_unsigned <= Unsigned(reg32n_q_logic_vector);

	--===============================================================--
	hex_display_array: for i in 5 downto 0 generate 
	-------------------------------------------------------------------
		sevenSeg_vhd: sevenSeg 
			generic map (
				DISPLAY_MODE			=> '0')
			port map (
				SEG_IN					=> sevenSeg_seg_in(i),
				SEG_OUT					=> sevenSeg_seg_out(i),
				LOAD_DATA				=> sevenSeg_load_data(i));

	-------------------------------------------------------------------		
	end generate hex_display_array;
	
	load_data_ctrl: for i in 5 downto 0 generate
		sevenSeg_load_data(i) <= SW(9);
		sevenSeg_seg_in(i) <= reg32n_q_logic_vector(3 downto 0);
	end generate load_data_ctrl;

	HEX0 <= sevenSeg_seg_out(0);
	HEX1 <= sevenSeg_seg_out(1);
	HEX2 <= sevenSeg_seg_out(2);
	HEX3 <= sevenSeg_seg_out(3);
	HEX4 <= sevenSeg_seg_out(4);
	HEX5 <= sevenSeg_seg_out(5);

end;


