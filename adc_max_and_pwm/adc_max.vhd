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
use ieee.numeric_std.all;

entity adc_max is 
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


architecture rtl of adc_max is
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
	signal sevenSegArray_data_unsigned: Unsigned (31 downto 0);
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


	-- qsys MAX10 ADC component
	component adc_qsys is
	port (
		clk_clk                              : in  std_logic                     := 'X';             -- clk
		clock_bridge_sys_out_clk_clk         : out std_logic;                                        -- clk
		modular_adc_0_command_valid          : in  std_logic                     := 'X';             -- valid
		modular_adc_0_command_channel        : in  std_logic_vector(4 downto 0)  := (others => 'X'); -- channel
		modular_adc_0_command_startofpacket  : in  std_logic                     := 'X';             -- startofpacket
		modular_adc_0_command_endofpacket    : in  std_logic                     := 'X';             -- endofpacket
		modular_adc_0_command_ready          : out std_logic;                                        -- ready
		modular_adc_0_response_valid         : out std_logic;                                        -- valid
		modular_adc_0_response_channel       : out std_logic_vector(4 downto 0);                     -- channel
		modular_adc_0_response_data          : out std_logic_vector(11 downto 0);                    -- data
		modular_adc_0_response_startofpacket : out std_logic;                                        -- startofpacket
		modular_adc_0_response_endofpacket   : out std_logic;                                        -- endofpacket
		reset_reset_n                        : in  std_logic                     := 'X'              -- reset_n
	);
	end component adc_qsys;
	
	component display_dec is
	port (
		hex : in std_logic_vector(3 downto 0);
		dot : in std_logic;
		disp : out std_logic_vector(7 downto 0)
	);
	end component display_dec;

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
	signal reset_n : std_logic;
	signal rdaddress	: std_logic_vector(15 downto 0);
	signal wraddress	: std_logic_vector(9 downto 0);
	signal sram_data  : std_logic_vector(11 downto 0);
	signal wren : std_logic;
	
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
	-- HEXn
	HEX0 <= sevenSegArray_HEX0_logic_vector;
	HEX1 <= sevenSegArray_HEX1_logic_vector;
	HEX2 <= sevenSegArray_HEX2_logic_vector;
	HEX3 <= sevenSegArray_HEX3_logic_vector;
	HEX4 <= sevenSegArray_HEX4_logic_vector;
	HEX5 <= sevenSegArray_HEX5_logic_vector;

	sevenSegArray_clock_logic <= MAX10_CLK1_50;
	sevenSegArray_data_integer <= 6*To_integer(Unsigned(adc_sample_data))/5;

	-- displays(0) <= adc_sample_data(3 downto 0);
	-- displays(1) <= adc_sample_data(7 downto 4);
	-- displays(2) <= adc_sample_data(11 downto 8);
	-- displays(3) <= (others => '0');
	-- displays(4) <= (others => '0');
	-- displays(5) <= cur_adc_ch(3 downto 0);

	-- LEDR(0) <= SW(0);
	
	command_startofpacket <= '1';
	command_endofpacket <= '1';
	command_valid <= '1';
	
	command_channel <= SW(4 downto 0);
	reset <= SW(9);
	reset_n <= not reset;
	LEDR(9) <= reset;
	
	--ARDUINO_IO(0) <= response_valid;
	
	-- displays(0) <= adc_sample_data(3 downto 0);
	-- displays(1) <= adc_sample_data(7 downto 4);
	-- displays(2) <= adc_sample_data(11 downto 8);
	-- displays(3) <= (others => '0');
	-- displays(4) <= (others => '0');
	-- displays(5) <= cur_adc_ch(3 downto 0);
	
	-- HEX0 <= displays_out(0);
	-- HEX1 <= displays_out(1);
	-- HEX2 <= displays_out(2);
	-- HEX3 <= displays_out(3);
	-- HEX4 <= displays_out(4);
	-- HEX5 <= displays_out(5);
	
	LEDR(4 downto 0) <= response_channel;
	
	hex_gen : for i in 0 to 5 generate
	hex_dec: display_dec
		port map (
			hex => displays(i),
			dot => '0',
			disp => displays_out(i)
		);
	end generate;
		
	u0 : component adc_qsys
	port map (
		clk_clk                              => MAX10_CLK1_50,  
		clock_bridge_sys_out_clk_clk         => sys_clk,       
		modular_adc_0_command_valid          => command_valid,      	 
		modular_adc_0_command_channel        => command_channel,        
		modular_adc_0_command_startofpacket  => command_startofpacket, 
		modular_adc_0_command_endofpacket    => command_endofpacket,    
		modular_adc_0_command_ready          => command_ready,          
		modular_adc_0_response_valid         => response_valid,         
		modular_adc_0_response_channel       => response_channel,       
		modular_adc_0_response_data          => response_data,          
		modular_adc_0_response_startofpacket => response_startofpacket, 
		modular_adc_0_response_endofpacket   => response_endofpacket,   
		reset_reset_n                        => reset_n                       
	);
	
			
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
	
	process (sys_clk, reset)	
	begin
		if reset = '1' then
			rdaddress <= (others => '0');	
			wren <= '0';
		else			
			--wren <= '0';
			if (rising_edge(sys_clk) and response_valid = '1') then						
				--if (rdaddress < x"400") then
					rdaddress <= rdaddress + x"0001";
					wren <= '1';
			--else
				--wren <= '0';			
			end if;				
			--end if;
		end if;					
	end process;
end;

