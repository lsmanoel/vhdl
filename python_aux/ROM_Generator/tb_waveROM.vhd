library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.waveROM_package.all;

entity tb_wave_rom is
end entity;

architecture waveform of tb_wave_rom is
	-------------------------------------------------------------------
	-- CLOCK
	signal clk1_50_logic: std_logic;
	signal clk2_50_logic: std_logic;

	-------------------------------------------------------------------
	-- ROM32n	
	component wave_rom32n is
		port (
			CLOCK: in std_logic;
			ADDRESS: in integer  range 0 to 1023;
			Q: out std_logic_vector (31 downto 0)
		);	
	end component;

	signal wave_rom32n_clock_logic: std_logic;

	signal wave_rom32n_address_integer: integer range 0 to 1023;
	signal wave_rom32n_address_unsigned: Unsigned(9 downto 0);
	signal wave_rom32n_address_logic_vector: std_logic_vector(9 downto 0);

	signal wave_rom32n_q_integer: integer;
	signal wave_rom32n_q_unsigned: Unsigned (31 downto 0);
	signal wave_rom32n_q_logic_vector: std_logic_vector (31 downto 0);

	-------------------------------------------------------------------
	-- SIGNAL_WAVE_ROM32n_LOGIC_VECTOR_ARRAY	
	signal signal_wave_rom32n_logic_vector_array: wave_rom_logic_vector_array;

begin
	--===============================================================--
	-- CLOCK
	CLOCK_1_50: process -- 50 MHz phase 0
	begin
		clk1_50_logic <= '1';
		wait for 10 ns;
		clk1_50_logic <= '0';
		wait for 10 ns;
	end process;

	CLOCK_2_50: process -- 50 MHz phase pi
	begin
		clk2_50_logic <= '0';
		wait for 10 ns;
		clk2_50_logic <= '1';
		wait for 10 ns;
	end process;

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
	-- SIGNAL_WAVEROM_LOGIC_VECTOR_ARRAY
	signal_wave_rom_logic_vector_array <= rom_core;
end; 