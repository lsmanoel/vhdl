-------------------------------------------------------------------
-- Name        : de0_lite.vhd
-- Author      : 
-- Version     : 0.1
-- Copyright   : Departamento de Eletrônica, Florianópolis, IFSC
-- Description : Projeto base DE10-Lite
-------------------------------------------------------------------

LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity testbench is 
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
		DRAM_WE_N: out std_logic;
		
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
end entity;


architecture rtl of testbench is
	-- qsys MAX10 ADC component
	
	component display_dec is
	port (
		hex : in std_logic_vector(3 downto 0);
		dot : in std_logic;
		disp : out std_logic_vector(7 downto 0)
	);
	end component display_dec;
	
	component sram
	PORT
	(
		address		: in std_logic_vector (9 downto 0);
		clock		: in std_logic  := '1';
		data		: in std_logic_vector (11 downto 0);
		wren		: in std_logic ;
		q		: out std_logic_vector (11 downto 0)
	);
	end component;

	type displays_type is array (0 to 5) of std_logic_vector (3 downto 0);
	type displays_out_type is array (0 to 5) of std_logic_vector (7 downto 0);
	
	signal displays : displays_type;
	signal displays_out : displays_out_type;
	
	signal sys_clk : std_logic;	
	signal command_valid : std_logic;
	signal command_channel : std_logic_vector(4 downto 0);
	signal command_startofpacket : std_logic;
	signal command_endofpacket : std_logic;
	signal command_ready : std_logic;
	signal response_valid : std_logic;
	signal response_channel : std_logic_vector(4 downto 0);
	signal response_data : std_logic_vector(11 downto 0);
	signal response_startofpacket : std_logic;
	signal response_endofpacket : std_logic;
	
	signal adc_sample_data : std_logic_vector(11 downto 0);
	signal cur_adc_ch : std_logic_vector(4 downto 0);
	
	signal reset : std_logic;
	signal rdaddress	: std_logic_vector(9 downto 0);
	signal sram_data  : std_logic_vector(11 downto 0);
	signal wren : std_logic;
	
begin
	--LEDR(0) <= SW(0);
	
	command_startofpacket <= '1';
	command_endofpacket <= '1';
	command_valid <= '1';
	
	command_channel <= SW(4 downto 0);
	-- reset <= SW(5);
		
	displays(0) <= adc_sample_data(3 downto 0);
	displays(1) <= adc_sample_data(7 downto 4);
	displays(2) <= adc_sample_data(11 downto 8);
	displays(3) <= (others => '0');
	displays(4) <= (others => '0');
	displays(5) <= cur_adc_ch(3 downto 0);
	
	HEX0 <= displays_out(0);
	HEX1 <= displays_out(1);
	HEX2 <= displays_out(2);
	HEX3 <= displays_out(3);
	HEX4 <= displays_out(4);
	HEX5 <= displays_out(5);
	
	LEDR(4 downto 0) <= response_channel;
	
	hex_gen : for i in 0 to 5 generate
	hex_dec: display_dec
		port map (
			hex => displays(i),
			dot => '0',
			disp => displays_out(i)
		);
	end generate;
		
			
	process(sys_clk, reset)	
	begin
		if reset = '1' then
			adc_sample_data <= (others => '0');
			cur_adc_ch <= (others => '0');
		else
			if (rising_edge(sys_clk) and response_valid = '1') then
				adc_sample_data <= response_data;
				cur_adc_ch <= response_channel;
			end if;
		end if;		
	end process;
	
	----------------------------------------------------
	process
	begin
		sys_clk <= '1';
		wait for 10 ns;
		sys_clk <= '0';
		wait for 10 ns;		
	end process;
	
	process
	begin
		response_valid <= '0';
		wait for 40 ns;
		response_valid <= '1';
		wait for 20 ns;
		response_valid <= '0';
		wait for 40 ns;
	end process;
	
	reset <= '1', '0' after 25 ns;	

end;

