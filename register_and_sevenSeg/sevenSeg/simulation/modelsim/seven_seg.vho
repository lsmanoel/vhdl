-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 15.0.0 Build 145 04/22/2015 SJ Web Edition"

-- DATE "05/06/2019 10:56:43"

-- 
-- Device: Altera 10M08DAF484C7G Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	sevenSeg IS
    PORT (
	seg_in : IN std_logic_vector(2 DOWNTO 0);
	seg_out : OUT std_logic_vector(6 DOWNTO 0)
	);
END sevenSeg;

-- Design Ports Information
-- seg_out[0]	=>  Location: PIN_T5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_out[1]	=>  Location: PIN_P3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_out[2]	=>  Location: PIN_M1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_out[3]	=>  Location: PIN_D6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_out[4]	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_out[5]	=>  Location: PIN_T2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_out[6]	=>  Location: PIN_R4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_in[2]	=>  Location: PIN_N3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_in[1]	=>  Location: PIN_F1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- seg_in[0]	=>  Location: PIN_Y4,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF sevenSeg IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_seg_in : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_seg_out : std_logic_vector(6 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \seg_out[0]~output_o\ : std_logic;
SIGNAL \seg_out[1]~output_o\ : std_logic;
SIGNAL \seg_out[2]~output_o\ : std_logic;
SIGNAL \seg_out[3]~output_o\ : std_logic;
SIGNAL \seg_out[4]~output_o\ : std_logic;
SIGNAL \seg_out[5]~output_o\ : std_logic;
SIGNAL \seg_out[6]~output_o\ : std_logic;
SIGNAL \seg_in[1]~input_o\ : std_logic;
SIGNAL \seg_in[2]~input_o\ : std_logic;
SIGNAL \seg_in[0]~input_o\ : std_logic;
SIGNAL \Mux6~0_combout\ : std_logic;
SIGNAL \Mux5~0_combout\ : std_logic;
SIGNAL \Mux4~0_combout\ : std_logic;
SIGNAL \Mux3~0_combout\ : std_logic;
SIGNAL \Mux2~0_combout\ : std_logic;
SIGNAL \Mux1~0_combout\ : std_logic;
SIGNAL \Mux0~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux2~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux4~0_combout\ : std_logic;
SIGNAL \ALT_INV_Mux5~0_combout\ : std_logic;

BEGIN

ww_seg_in <= seg_in;
seg_out <= ww_seg_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
\ALT_INV_Mux2~0_combout\ <= NOT \Mux2~0_combout\;
\ALT_INV_Mux4~0_combout\ <= NOT \Mux4~0_combout\;
\ALT_INV_Mux5~0_combout\ <= NOT \Mux5~0_combout\;

-- Location: LCCOMB_X11_Y13_N24
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X0_Y2_N16
\seg_out[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux6~0_combout\,
	devoe => ww_devoe,
	o => \seg_out[0]~output_o\);

-- Location: IOOBUF_X0_Y5_N16
\seg_out[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux5~0_combout\,
	devoe => ww_devoe,
	o => \seg_out[1]~output_o\);

-- Location: IOOBUF_X0_Y5_N9
\seg_out[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux4~0_combout\,
	devoe => ww_devoe,
	o => \seg_out[2]~output_o\);

-- Location: IOOBUF_X1_Y10_N9
\seg_out[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux3~0_combout\,
	devoe => ww_devoe,
	o => \seg_out[3]~output_o\);

-- Location: IOOBUF_X1_Y10_N30
\seg_out[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Mux2~0_combout\,
	devoe => ww_devoe,
	o => \seg_out[4]~output_o\);

-- Location: IOOBUF_X0_Y4_N9
\seg_out[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux1~0_combout\,
	devoe => ww_devoe,
	o => \seg_out[5]~output_o\);

-- Location: IOOBUF_X0_Y4_N16
\seg_out[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Mux0~0_combout\,
	devoe => ww_devoe,
	o => \seg_out[6]~output_o\);

-- Location: IOIBUF_X0_Y8_N8
\seg_in[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_seg_in(1),
	o => \seg_in[1]~input_o\);

-- Location: IOIBUF_X0_Y6_N1
\seg_in[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_seg_in(2),
	o => \seg_in[2]~input_o\);

-- Location: IOIBUF_X9_Y0_N8
\seg_in[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_seg_in(0),
	o => \seg_in[0]~input_o\);

-- Location: LCCOMB_X1_Y4_N0
\Mux6~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux6~0_combout\ = (\seg_in[1]~input_o\ & ((!\seg_in[0]~input_o\) # (!\seg_in[2]~input_o\))) # (!\seg_in[1]~input_o\ & (\seg_in[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \seg_in[1]~input_o\,
	datac => \seg_in[2]~input_o\,
	datad => \seg_in[0]~input_o\,
	combout => \Mux6~0_combout\);

-- Location: LCCOMB_X1_Y4_N10
\Mux5~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux5~0_combout\ = (\seg_in[1]~input_o\ & ((\seg_in[0]~input_o\) # (!\seg_in[2]~input_o\))) # (!\seg_in[1]~input_o\ & (!\seg_in[2]~input_o\ & \seg_in[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111100001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \seg_in[1]~input_o\,
	datac => \seg_in[2]~input_o\,
	datad => \seg_in[0]~input_o\,
	combout => \Mux5~0_combout\);

-- Location: LCCOMB_X1_Y4_N4
\Mux4~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux4~0_combout\ = (\seg_in[0]~input_o\) # ((!\seg_in[1]~input_o\ & \seg_in[2]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \seg_in[1]~input_o\,
	datac => \seg_in[2]~input_o\,
	datad => \seg_in[0]~input_o\,
	combout => \Mux4~0_combout\);

-- Location: LCCOMB_X1_Y4_N14
\Mux3~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux3~0_combout\ = (\seg_in[1]~input_o\ & ((!\seg_in[0]~input_o\) # (!\seg_in[2]~input_o\))) # (!\seg_in[1]~input_o\ & (\seg_in[2]~input_o\ $ (!\seg_in[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \seg_in[1]~input_o\,
	datac => \seg_in[2]~input_o\,
	datad => \seg_in[0]~input_o\,
	combout => \Mux3~0_combout\);

-- Location: LCCOMB_X1_Y4_N16
\Mux2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux2~0_combout\ = (\seg_in[1]~input_o\ & (!\seg_in[2]~input_o\ & !\seg_in[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \seg_in[1]~input_o\,
	datac => \seg_in[2]~input_o\,
	datad => \seg_in[0]~input_o\,
	combout => \Mux2~0_combout\);

-- Location: LCCOMB_X1_Y4_N18
\Mux1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux1~0_combout\ = (\seg_in[1]~input_o\ $ (!\seg_in[0]~input_o\)) # (!\seg_in[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111100111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \seg_in[1]~input_o\,
	datac => \seg_in[2]~input_o\,
	datad => \seg_in[0]~input_o\,
	combout => \Mux1~0_combout\);

-- Location: LCCOMB_X1_Y4_N20
\Mux0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Mux0~0_combout\ = (\seg_in[1]~input_o\) # (\seg_in[2]~input_o\ $ (!\seg_in[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \seg_in[1]~input_o\,
	datac => \seg_in[2]~input_o\,
	datad => \seg_in[0]~input_o\,
	combout => \Mux0~0_combout\);

-- Location: UNVM_X0_Y11_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X10_Y24_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

ww_seg_out(0) <= \seg_out[0]~output_o\;

ww_seg_out(1) <= \seg_out[1]~output_o\;

ww_seg_out(2) <= \seg_out[2]~output_o\;

ww_seg_out(3) <= \seg_out[3]~output_o\;

ww_seg_out(4) <= \seg_out[4]~output_o\;

ww_seg_out(5) <= \seg_out[5]~output_o\;

ww_seg_out(6) <= \seg_out[6]~output_o\;
END structure;


