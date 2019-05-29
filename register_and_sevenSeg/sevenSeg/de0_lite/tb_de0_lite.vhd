library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_de0_lite is
end entity;

architecture waveform of tb_de0_lite is
	-------------------------------------------------------------------
	-- CLOCK
	signal adc_clk_10_logic: std_logic;
	signal max10_clk1_50_logic: std_logic;
	signal max10_clk2_50_logic:	std_logic;
	
	-------------------------------------------------------------------
	-- SDRAM
	signal dram_addr_integer: integer range 0 to 4095;
	signal dram_addr_unsigned: Unsigned (12 downto 0);
	signal dram_addr_logic_vector: std_logic_vector (12 downto 0);

	signal dram_ba_integer: integer range 0 to 3;
	signal dram_ba_unsigned: Unsigned(1 downto 0); 
	signal dram_ba_logic_vector: std_logic_vector (1 downto 0);

	signal dram_cas_n_logic: std_logic;
	signal dram_cke_logic: std_logic;
	signal dram_clk_logic: std_logic;
	signal dram_cs_n_logic: std_logic;

	signal dram_dq_integer: integer range 0 to 65535;
	signal dram_dq_unsigned: Unsigned (15 downto 0);
	signal dram_dq_logic_vector: std_logic_vector (15 downto 0);

	signal dram_ldqm_logic: std_logic;
	signal dram_ras_n_logic: std_logic;
	signal dram_udqm_logic:	std_logic;
	signal ram_we_n_logic: std_logic;
	
	-------------------------------------------------------------------
	-- SEG7
	signal hex0_integer: integer range 0 to 255;
	signal hex0_unsigned: Unsigned (7 downto 0);
	signal hex0_logic_vector: std_logic_vector (7 downto 0);

	signal hex1_integer: integer range 0 to 255;
	signal hex1_unsigned: Unsigned (7 downto 0); 
	signal hex1_logic_vector: std_logic_vector (7 downto 0);

	signal hex2_integer: integer range 0 to 255;  
	signal hex2_unsigned: Unsigned(7 downto 0);  
	signal hex2_logic_vector: std_logic_vector (7 downto 0); 

	signal hex3_integer: integer range 0 to 255;
	signal hex3_unsigned: Unsigned (7 downto 0); 
	signal hex3_logic_vector: std_logic_vector (7 downto 0);

	signal hex4_integer: integer range 0 to 255;
	signal hex4_unsigned: Unsigned(7 downto 0); 
	signal hex4_logic_vector: std_logic_vector (7 downto 0);

	signal hex5_integer: integer range 0 to 255;
	signal hex5_unsigned: Unsigned (7 downto 0); 
	signal hex5_logic_vector: std_logic_vector(7 downto 0);

	-------------------------------------------------------------------
	-- KEY
	signal key_integer: integer range 0 to 3;
	signal key_unsigned: Unsigned(1 downto 0);
	signal key_logic_vector: std_logic_vector(1 downto 0);

	-------------------------------------------------------------------
	-- LED
	signal ledr_integer: integer range 0 to 1023;
	signal ledr_unsigned: Unsigned (9 downto 0);
	signal ledr_logic_vector: std_logic_vector(9 downto 0);

	-------------------------------------------------------------------
	-- SW
	signal sw_integer: integer range 0 to 1023;
	signal sw_unsigned: Unsigned (9 downto 0);
	signal sw_logic_vector: std_logic_vector(9 downto 0);

	-------------------------------------------------------------------
	-- VGA
	signal vga_r_integer: integer range 0 to 16;
	signal vga_r_unsigned: Unsigned (3 downto 0);
	signal vga_r_logic_vector: std_logic_vector(3 downto 0);

	signal vga_g_integer: integer range 0 to 16;
	signal vga_g_unsigned: Unsigned (3 downto 0);
	signal vga_g_logic_vector: std_logic_vector(3 downto 0);

	signal vga_b_integer: integer range 0 to 16;
	signal vga_b_unsigned: Unsigned ( 3 downto 0);
	signal vga_b_logic_vector: std_logic_vector(3 downto 0);

	signal vga_hs_logic: std_logic;
	signal vga_vs_logic: std_logic;

	-------------------------------------------------------------------
	-- Accelerometer
	signal gsensor_cs_n_logic: std_logic;

	signal gsensor_int_integer: integer range 2 to 4;
	signal gsensor_int_unsigned: Unsigned (2 downto 1);
	signal gsensor_int_logic_vector: std_logic_vector (2 downto 1);

	signal gsensor_sclk_logic: std_logic;
	signal gsensor_sdi_logic: std_logic;
	signal gsensor_sdo_logic: std_logic;

	-------------------------------------------------------------------
	-- Arduino
	signal arduino_io_integer: integer range 0 to 65535;
	signal arduino_io_unsigned: Unsigned (15 downto 0);
	signal arduino_io_logic_vector: std_logic_vector (15 downto 0);

	signal arduino_reset_n_logic: std_logic;	

	-------------------------------------------------------------------
	-- de0_lite	
	component de0_lite is
		port (
			---------- CLOCK ----------
			ADC_CLK_10:	in std_logic;
			MAX10_CLK1_50: in std_logic;
			MAX10_CLK2_50: in std_logic;
			
			----------- SDRAM ------------
			DRAM_ADDR: out std_logic_vector (12 downto 0);
			DRAM_BA: out std_logic_vector (1 downto 0);
			DRAM_CAS_N: out std_logic;
			DRAM_CKE: out std_logic;
			DRAM_CLK: out std_logic;
			DRAM_CS_N: out std_logic;		
			DRAM_DQ: inout std_logic_vector(15 downto 0);
			DRAM_LDQM: out std_logic;
			DRAM_RAS_N: out std_logic;
			DRAM_UDQM: out std_logic;
			RAM_WE_N: out std_logic;
			
			----------- SEG7 ------------
			HEX0: out std_logic_vector(7 downto 0);
			HEX1: out std_logic_vector(7 downto 0);
			HEX2: out std_logic_vector(7 downto 0);
			HEX3: out std_logic_vector(7 downto 0);
			HEX4: out std_logic_vector(7 downto 0);
			HEX5: out std_logic_vector(7 downto 0);

			----------- KEY ------------
			KEY: in std_logic_vector(1 downto 0);

			----------- LED ------------
			LEDR: out std_logic_vector(9 downto 0);

			----------- SW ------------
			SW: in std_logic_vector(9 downto 0);

			----------- VGA ------------
			VGA_B: out std_logic_vector(3 downto 0);
			VGA_G: out std_logic_vector(3 downto 0);
			VGA_HS: out std_logic;
			VGA_R: out std_logic_vector(3 downto 0);
			VGA_VS: out std_logic;
		
			----------- Accelerometer ------------
			GSENSOR_CS_N: out std_logic;
			GSENSOR_INT: in std_logic_vector(2 downto 1);
			GSENSOR_SCLK: out std_logic;
			GSENSOR_SDI: inout std_logic;
			GSENSOR_SDO: inout std_logic;
		
			----------- Arduino ------------
			ARDUINO_IO: inout std_logic_vector(15 downto 0);
			ARDUINO_RESET_N: inout std_logic
		);
	end component;

	signal de0_lite_adc_clk_10_logic: std_logic;
	
	signal de0_lite_max10_clk1_50_logic: std_logic;
	signal de0_lite_max10_clk2_50_logic: std_logic;

	signal de0_lite_dram_addr_integer: integer range 0 to 4095;
	signal de0_lite_dram_addr_unsigned: Unsigned (12 downto 0);
	signal de0_lite_dram_addr_logic_vector: std_logic_vector (12 downto 0);
	signal de0_lite_dram_ba_integer: integer range 0 to 3;
	signal de0_lite_dram_ba_unsigned: Unsigned(1 downto 0); 
	signal de0_lite_dram_ba_logic_vector: std_logic_vector (1 downto 0);
	signal de0_lite_dram_cas_n_logic: std_logic;
	signal de0_lite_dram_cke_logic: std_logic;
	signal de0_lite_dram_clk_logic: std_logic;
	signal de0_lite_dram_cs_n_logic: std_logic;
	signal de0_lite_dram_dq_integer: integer range 0 to 65535;
	signal de0_lite_dram_dq_unsigned: Unsigned (15 downto 0);
	signal de0_lite_dram_dq_logic_vector: std_logic_vector (15 downto 0);
	signal de0_lite_dram_ldqm_logic: std_logic;
	signal de0_lite_dram_ras_n_logic: std_logic;
	signal de0_lite_dram_udqm_logic:	std_logic;
	
	signal de0_lite_ram_we_n_logic: std_logic;
	
	signal de0_lite_hex0_integer: integer range 0 to 255;
	signal de0_lite_hex0_unsigned: Unsigned (7 downto 0);
	signal de0_lite_hex0_logic_vector: std_logic_vector (7 downto 0);
	
	signal de0_lite_hex1_integer: integer range 0 to 255;
	signal de0_lite_hex1_unsigned: Unsigned (7 downto 0); 
	signal de0_lite_hex1_logic_vector: std_logic_vector (7 downto 0);
	
	signal de0_lite_hex2_integer: integer range 0 to 255;  
	signal de0_lite_hex2_unsigned: Unsigned(7 downto 0);  
	signal de0_lite_hex2_logic_vector: std_logic_vector (7 downto 0); 
	
	signal de0_lite_hex3_integer: integer range 0 to 255;
	signal de0_lite_hex3_unsigned: Unsigned (7 downto 0); 
	signal de0_lite_hex3_logic_vector: std_logic_vector (7 downto 0);
	
	signal de0_lite_hex4_integer: integer range 0 to 255;
	signal de0_lite_hex4_unsigned: Unsigned(7 downto 0); 
	signal de0_lite_hex4_logic_vector: std_logic_vector (7 downto 0);
	
	signal de0_lite_hex5_integer: integer range 0 to 255;
	signal de0_lite_hex5_unsigned: Unsigned (7 downto 0); 
	signal de0_lite_hex5_logic_vector: std_logic_vector(7 downto 0);

	signal de0_lite_key_integer: integer range 0 to 3;
	signal de0_lite_key_unsigned: Unsigned(1 downto 0);
	signal de0_lite_key_logic_vector: std_logic_vector(1 downto 0);

	signal de0_lite_ledr_integer: integer range 0 to 1023;
	signal de0_lite_ledr_unsigned: Unsigned (9 downto 0);
	signal de0_lite_ledr_logic_vector: std_logic_vector(9 downto 0);

	signal de0_lite_sw_integer: integer range 0 to 1023;
	signal de0_lite_sw_unsigned: Unsigned (9 downto 0);
	signal de0_lite_sw_logic_vector: std_logic_vector(9 downto 0);

	signal de0_lite_vga_r_integer: integer range 0 to 16;
	signal de0_lite_vga_r_unsigned: Unsigned (3 downto 0);
	signal de0_lite_vga_r_logic_vector: std_logic_vector(3 downto 0);
	signal de0_lite_vga_g_integer: integer range 0 to 16;
	signal de0_lite_vga_g_unsigned: Unsigned (3 downto 0);
	signal de0_lite_vga_g_logic_vector: std_logic_vector(3 downto 0);
	signal de0_lite_vga_b_integer: integer range 0 to 16;
	signal de0_lite_vga_b_unsigned: Unsigned ( 3 downto 0);
	signal de0_lite_vga_b_logic_vector: std_logic_vector(3 downto 0);
	signal de0_lite_vga_hs_logic: std_logic;
	signal de0_lite_vga_vs_logic: std_logic;

	signal de0_lite_gsensor_cs_n_logic: std_logic;
	signal de0_lite_gsensor_int_integer: integer range 0 to 2;
	signal de0_lite_gsensor_int_unsigned: Unsigned (2 downto 1);
	signal de0_lite_gsensor_int_logic_vector: std_logic_vector (2 downto 1);
	signal de0_lite_gsensor_sclk_logic: std_logic;
	signal de0_lite_gsensor_sdi_logic: std_logic;
	signal de0_lite_gsensor_sdo_logic: std_logic;

	signal de0_lite_arduino_io_integer: integer range 0 to 65535;
	signal de0_lite_arduino_io_unsigned: Unsigned (15 downto 0);
	signal de0_lite_arduino_io_logic_vector: std_logic_vector (15 downto 0);
	signal de0_lite_arduino_reset_n_logic: std_logic;	

begin
	--===============================================================--
	-- CLOCK
	CLOCK_1_50: process -- 50 MHz phase 0
	begin
		max10_clk1_50_logic <= '1';
		wait for 10 ns;
		max10_clk1_50_logic <= '0';
		wait for 10 ns;
	end process;

	CLOCK_2_50: process -- 50 MHz phase pi
	begin
		max10_clk2_50_logic <= '0';
		wait for 10 ns;
		max10_clk2_50_logic <= '1';
		wait for 10 ns;
	end process;

	CLOCK_ADC_10: process -- 10 MHz phase 0
	begin
		adc_clk_10_logic <= '1';
		wait for 50 ns;
		adc_clk_10_logic <= '0';
		wait for 50 ns;
	end process;

	--===============================================================--
	-- DRAM

	--===============================================================--
	-- HEX0

	--===============================================================--
	-- HEX1

	--===============================================================--
	-- HEX2

	--===============================================================--
	-- HEX3

	--===============================================================--
	-- HEX4

	--===============================================================--
	-- HEX5

	--===============================================================--
	-- KEY

	--===============================================================--
	-- LEDR

	--===============================================================--
	-- SW

	--===============================================================--
	-- VGA

	--===============================================================--
	-- GSENSOR

	--===============================================================--
	-- ARDUINO

	--===============================================================--
	de0_lite_vhd: 	de0_lite 
		port map(
			ADC_CLK_10		=> de0_lite_adc_clk_10_logic,
			MAX10_CLK1_50	=> de0_lite_max10_clk1_50_logic,
			MAX10_CLK2_50	=> de0_lite_max10_clk2_50_logic,

			DRAM_ADDR		=> de0_lite_dram_addr_logic_vector,
			DRAM_BA			=> de0_lite_dram_ba_logic_vector,
			DRAM_CAS_N		=> de0_lite_dram_cas_n_logic,
			DRAM_CKE		=> de0_lite_dram_cke_logic,
			DRAM_CLK		=> de0_lite_dram_clk_logic,
			DRAM_CS_N		=> de0_lite_dram_cs_n_logic,		
			DRAM_DQ			=> de0_lite_dram_dq_logic_vector,
			DRAM_LDQM		=> de0_lite_dram_ldqm_logic,
			DRAM_RAS_N		=> de0_lite_dram_ras_n_logic,
			DRAM_UDQM		=> de0_lite_dram_udqm_logic,
			RAM_WE_N		=> de0_lite_ram_we_n_logic,

			HEX0			=> de0_lite_hex0_logic_vector,
			HEX1			=> de0_lite_hex1_logic_vector,
			HEX2			=> de0_lite_hex2_logic_vector,
			HEX3			=> de0_lite_hex3_logic_vector,
			HEX4			=> de0_lite_hex4_logic_vector,
			HEX5			=> de0_lite_hex5_logic_vector,

			KEY				=> de0_lite_key_logic_vector,

			LEDR 			=> de0_lite_ledr_logic_vector,

			SW 				=> de0_lite_sw_logic_vector,

			VGA_R			=> de0_lite_vga_r_logic_vector,
			VGA_B 			=> de0_lite_vga_b_logic_vector,
			VGA_G 			=> de0_lite_vga_g_logic_vector,
			VGA_HS			=> de0_lite_vga_hs_logic,
			VGA_VS			=> de0_lite_vga_vs_logic,

			GSENSOR_CS_N	=> de0_lite_gsensor_cs_n_logic,
			GSENSOR_INT		=> de0_lite_gsensor_int_logic_vector,
			GSENSOR_SCLK	=> de0_lite_gsensor_sclk_logic,
			GSENSOR_SDI		=> de0_lite_gsensor_sdi_logic,
			GSENSOR_SDO		=> de0_lite_gsensor_sdo_logic,

			ARDUINO_IO 		=> de0_lite_arduino_io_logic_vector,
			ARDUINO_RESET_N	=> de0_lite_arduino_reset_n_logic	
		);


	de0_lite_dram_addr_unsigned <= Unsigned(de0_lite_dram_addr_logic_vector);
	de0_lite_dram_addr_integer <= To_integer(de0_lite_dram_addr_unsigned);
	de0_lite_dram_ba_unsigned <= Unsigned(de0_lite_dram_ba_logic_vector);
	de0_lite_dram_ba_integer <= To_integer(de0_lite_dram_ba_unsigned);
	de0_lite_dram_dq_unsigned <= Unsigned(de0_lite_dram_dq_logic_vector);
	de0_lite_dram_dq_integer <= To_integer(de0_lite_dram_dq_unsigned);

	de0_lite_hex0_unsigned <= Unsigned(de0_lite_hex0_logic_vector);
	de0_lite_hex0_integer <= To_integer(de0_lite_hex0_unsigned);

	de0_lite_hex1_unsigned <= Unsigned(de0_lite_hex1_logic_vector);
	de0_lite_hex1_integer <= To_integer(de0_lite_hex1_unsigned);

	de0_lite_hex2_unsigned <= Unsigned(de0_lite_hex2_logic_vector);
	de0_lite_hex2_integer <= To_integer(de0_lite_hex2_unsigned);

	de0_lite_hex3_unsigned <= Unsigned(de0_lite_hex3_logic_vector);
	de0_lite_hex3_integer <= To_integer(de0_lite_hex3_unsigned);

	de0_lite_hex4_unsigned <= Unsigned(de0_lite_hex4_logic_vector);
	de0_lite_hex4_integer <= To_integer(de0_lite_hex4_unsigned);

	de0_lite_hex5_unsigned <= Unsigned(de0_lite_hex5_logic_vector);
	de0_lite_hex5_integer <= To_integer(de0_lite_hex5_unsigned);

	de0_lite_key_unsigned <= Unsigned(de0_lite_key_logic_vector);
	de0_lite_key_integer <= To_integer(de0_lite_key_unsigned);

	de0_lite_ledr_unsigned <= Unsigned(de0_lite_ledr_logic_vector);
	de0_lite_ledr_integer <= To_integer(de0_lite_ledr_unsigned);

	de0_lite_sw_unsigned <= Unsigned(de0_lite_sw_logic_vector);
	de0_lite_sw_integer <= To_integer(de0_lite_sw_unsigned);

	de0_lite_vga_r_unsigned <= Unsigned(de0_lite_vga_r_logic_vector);
	de0_lite_vga_r_integer <= To_integer(de0_lite_vga_r_unsigned);
	de0_lite_vga_b_unsigned <= Unsigned(de0_lite_vga_b_logic_vector);
	de0_lite_vga_b_integer <= To_integer(de0_lite_vga_b_unsigned);
	de0_lite_vga_g_unsigned <= Unsigned(de0_lite_vga_g_logic_vector);
	de0_lite_vga_g_integer <= To_integer(de0_lite_vga_g_unsigned);

	de0_lite_gsensor_int_unsigned <= Unsigned(de0_lite_gsensor_int_logic_vector);
	de0_lite_gsensor_int_integer <= To_integer(de0_lite_gsensor_int_unsigned);

	de0_lite_arduino_io_unsigned <= Unsigned(de0_lite_arduino_io_logic_vector);
	de0_lite_arduino_io_integer <= To_integer(de0_lite_arduino_io_unsigned);

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- CLOCK
	de0_lite_adc_clk_10_logic <= adc_clk_10_logic; 
	de0_lite_max10_clk1_50_logic <= max10_clk1_50_logic; 
	de0_lite_max10_clk2_50_logic <= max10_clk2_50_logic; 

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- SEVENSEG
	hex0_logic_vector <= de0_lite_hex0_logic_vector;
	hex1_logic_vector <= de0_lite_hex1_logic_vector;
	hex2_logic_vector <= de0_lite_hex2_logic_vector;
	hex3_logic_vector <= de0_lite_hex3_logic_vector;
	hex4_logic_vector <= de0_lite_hex4_logic_vector;
	hex5_logic_vector <= de0_lite_hex5_logic_vector;

end architecture;