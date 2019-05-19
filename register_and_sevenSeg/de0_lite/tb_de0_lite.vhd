library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_de0_lite is
end entity;

architecture waveform of tb_de0_lite is
	---------- CLOCK ----------
	signal adc_clk_10:			std_logic;
	signal max10_clk1_50:		std_logic;
	signal max10_clk2_50:		std_logic;
	
	----------- SDRAM ------------
	signal dram_addr:			std_logic_vector (12 downto 0);
	signal dram_ba:			 	std_logic_vector (1 downto 0);
	signal dram_cas_n:			std_logic;
	signal dram_cke:			std_logic;
	signal dram_clk:			std_logic;
	signal dram_cs_n:			std_logic;		
	signal dram_dq:			 	std_logic_vector(15 downto 0);
	signal dram_ldqm:			std_logic;
	signal dram_ras_n:			std_logic;
	signal dram_udqm:			std_logic;
	signal ram_we_n:			std_logic;
	
	----------- SEG7 ------------
	signal hex0:				std_logic_vector(7 downto 0);
	signal hex1:				std_logic_vector(7 downto 0);
	signal hex2:				std_logic_vector(7 downto 0);
	signal hex3:				std_logic_vector(7 downto 0);
	signal hex4:				std_logic_vector(7 downto 0);
	signal hex5:				std_logic_vector(7 downto 0);

	----------- KEY ------------
	signal key:					std_logic_vector(1 downto 0);

	----------- LED ------------
	signal ledr:				std_logic_vector(9 downto 0);

	----------- SW ------------
	signal sw:					std_logic_vector(9 downto 0);

	----------- VGA ------------
	signal vga_b:				std_logic_vector(3 downto 0);
	signal vga_g:				std_logic_vector(3 downto 0);
	signal vga_hs:				std_logic;
	signal vga_r:				std_logic_vector(3 downto 0);
	signal vga_vs:				std_logic;

	----------- Accelerometer ------------
	signal gsensor_cs_n:		std_logic;
	signal gsensor_int:			std_logic_vector(2 downto 1);
	signal gsensor_sclk:		std_logic;
	signal gsensor_sdi:			std_logic;
	signal gsensor_sdo:			std_logic;

	----------- Arduino ------------
	signal arduino_io:			std_logic_vector(15 downto 0);
	signal arduino_reset_n:		std_logic;	

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
	 	
begin

	de0_lite_vhd: 	de0_lite 
					port map(
						---------- CLOCK ----------
						ADC_CLK_10		=> adc_clk_10,
						MAX10_CLK1_50	=> max10_clk1_50,
						MAX10_CLK2_50	=> max10_clk2_50,

						----------- SDRAM ------------
						DRAM_ADDR		=> dram_addr,
						DRAM_BA			=> dram_ba,
						DRAM_CAS_N		=> dram_cas_n,
						DRAM_CKE		=> dram_cke,
						DRAM_CLK		=> dram_clk,
						DRAM_CS_N		=> dram_cs_n,		
						DRAM_DQ			=> dram_dq,
						DRAM_LDQM		=> dram_ldqm,
						DRAM_RAS_N		=> dram_ras_n,
						DRAM_UDQM		=> dram_udqm,
						RAM_WE_N		=> ram_we_n,

						----------- SEG7 ------------
						HEX0			=> hex0,
						HEX1			=> hex1,
						HEX2			=> hex2,
						HEX3			=> hex3,
						HEX4			=> hex4,
						HEX5			=> hex5,

						----------- KEY ------------
						KEY				=> key,

						----------- LED ------------
						LEDR 			=> ledr,

						----------- SW ------------
						SW 				=> sw,

						----------- VGA ------------
						VGA_R			=> vga_r,
						VGA_B 			=> vga_b,
						VGA_G 			=> vga_g,
						VGA_HS			=> vga_hs,
						VGA_VS			=> vga_vs,

						----------- Accelerometer ------------
						GSENSOR_CS_N	=> gsensor_cs_n,
						GSENSOR_INT		=> gsensor_int,
						GSENSOR_SCLK	=> gsensor_sclk,
						GSENSOR_SDI		=> gsensor_sdi,
						GSENSOR_SDO		=> gsensor_sdo,

						----------- Arduino ------------
						ARDUINO_IO 		=> arduino_io,
						ARDUINO_RESET_N	=> arduino_reset_n	
					);


	-----------  10 MHz phase 0  - sw counter - up ------------
	process	
		variable count: integer;	
	begin
		if count > 7 then
			count := 0;
		else
			count := count + 1;
		end if;	

		sw(3 downto 0) <= not std_logic_vector(To_unsigned(count, 4));
		
		wait for 200 ns;
    end process;								

	-----------  10 MHz phase 0  - sw counter - up ------------	
	process	
		variable count: integer;	
	begin
		if count > 7 then
			count := 0;
		else
			count := count + 1;
		end if;	

		sw(7 downto 4) <= not std_logic_vector(To_unsigned(count, 4));

		wait for 60 ns;
    end process;	

 	-----------  reg32n WE ------------
	WE: process
	begin
		sw(8) <= '0';
		wait for 100 ns;
		sw(8) <= '1';
		wait for 200 ns;
	end process WE;

    -----------  sevenSeg LOAD_DATA ------------	
	LOAD_DATA: process		
	begin
		sw(9) <= '0';
		wait for 100 ns;
		sw(9) <= '1';
		wait for 200 ns;
    end process;

	----------- 50 MHz phase 0 ------------
	CLOCK_1_50: process
	begin
		max10_clk1_50 <= '1';
		wait for 10 ns;
		max10_clk1_50 <= '0';
		wait for 10 ns;
	end process;

	----------- 50 MHz phase pi ------------
	CLOCK_2_50: process
	begin
		max10_clk2_50 <= '0';
		wait for 10 ns;
		max10_clk2_50 <= '1';
		wait for 10 ns;
	end process;

	----------- 10 MHz phase 0 ------------
	CLOCK_ADC_10: process
	begin
		adc_clk_10 <= '1';
		wait for 50 ns;
		adc_clk_10 <= '0';
		wait for 50 ns;
	end process;
 
end architecture;