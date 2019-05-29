library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hex2dig is
	port(
		CLOCK: in std_logic;
		DATA: in std_logic_vector (31 downto 0);
		DIG0: out integer range 0 to 31;
		DIG1: out integer range 0 to 31;
		DIG2: out integer range 0 to 31;
		DIG3: out integer range 0 to 31;
		DIG4: out integer range 0 to 31;
		DIG5: out integer range 0 to 31
	);
end;

architecture rtl of hex2dig is
	-------------------------------------------------------------------
	signal hex2dig_data_integer: integer;
	signal hex2dig_data_unsigned: Unsigned (31 downto 0);
	signal hex2dig_data_logic_vector: std_logic_vector (31 downto 0);

	signal hex2dig_dig0_integer: integer range 0 to 31;
	signal hex2dig_dig0_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig0_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig1_integer: integer range 0 to 31;
	signal hex2dig_dig1_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig1_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig2_integer: integer range 0 to 31;
	signal hex2dig_dig2_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig2_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig3_integer: integer range 0 to 31;
	signal hex2dig_dig3_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig3_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig4_integer: integer range 0 to 31;
	signal hex2dig_dig4_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig4_logic_vector: std_logic_vector (4 downto 0);

	signal hex2dig_dig5_integer: integer range 0 to 31;
	signal hex2dig_dig5_unsigned: Unsigned (4 downto 0);
	signal hex2dig_dig5_logic_vector: std_logic_vector (4 downto 0);	

	-------------------------------------------------------------------
	type main_state_type is(
		START_STATE,
		DIVIDE_STATE, 
		COMPARE_STATE,
		END_STATE);
	signal main_state: main_state_type:=END_STATE;

	procedure start_state_procedure(
				   DATA: in std_logic_vector (31 downto 0);
			signal DIG0, DIG1, DIG2, DIG3, DIG4, DIG5: out integer range 0 to 31) is
	begin
		--===============================================================--


	end start_state_procedure;

	procedure divide_state_procedure(
				DATA: in std_logic_vector (31 downto 0);
			signal DIG0, DIG1, DIG2, DIG3, DIG4, DIG5: out integer range 0 to 31) is
		
		variable buffer_integer: integer;	
	begin
		--===============================================================--
		buffer_integer := To_integer(Unsigned(DATA));

		DIG0 <= buffer_integer MOD 10;--0
		buffer_integer:=buffer_integer/10;
		DIG1 <= buffer_integer MOD 10;--1
		buffer_integer:=buffer_integer/10;
		DIG2 <= buffer_integer MOD 10;--2
		buffer_integer:=buffer_integer/10;
		DIG3 <= buffer_integer MOD 10;--3
		buffer_integer:=buffer_integer/10;
		DIG4 <= buffer_integer MOD 10;--4
		buffer_integer:=buffer_integer/10;
		DIG5 <= buffer_integer MOD 10;--5

	end divide_state_procedure;

	procedure compare_state_procedure(
				   DATA: in std_logic_vector (31 downto 0);
			signal DIG0, DIG1, DIG2, DIG3, DIG4, DIG5: out integer range 0 to 31) is
	begin
		--===============================================================--
	end compare_state_procedure;

	procedure end_state_procedure(
				   DATA: in std_logic_vector (31 downto 0);
			signal DIG0, DIG1, DIG2, DIG3, DIG4, DIG5: out integer range 0 to 31) is
	begin
		--===============================================================--
	end end_state_procedure;

begin
	--===============================================================--
	process(CLOCK)
	begin
		if clock'event and CLOCK = '1' then
			case main_state is
				when START_STATE =>
					main_state <= DIVIDE_STATE;
				when DIVIDE_STATE =>
					main_state <= DIVIDE_STATE;
				when COMPARE_STATE =>
					main_state <= END_STATE;
				when END_STATE =>
					main_state <= START_STATE;
			end case;
		end if;
	end process;

	process(main_state)
	begin
		case main_state is
			when START_STATE =>
				start_state_procedure(hex2dig_data_logic_vector, hex2dig_dig0_integer, hex2dig_dig1_integer, hex2dig_dig2_integer, hex2dig_dig3_integer, hex2dig_dig4_integer, hex2dig_dig5_integer);
			when DIVIDE_STATE =>
				divide_state_procedure(hex2dig_data_logic_vector, hex2dig_dig0_integer, hex2dig_dig1_integer, hex2dig_dig2_integer, hex2dig_dig3_integer, hex2dig_dig4_integer, hex2dig_dig5_integer);
			when COMPARE_STATE =>
				compare_state_procedure(hex2dig_data_logic_vector, hex2dig_dig0_integer, hex2dig_dig1_integer, hex2dig_dig2_integer, hex2dig_dig3_integer, hex2dig_dig4_integer, hex2dig_dig5_integer);
			when END_STATE =>
				end_state_procedure(hex2dig_data_logic_vector, hex2dig_dig0_integer, hex2dig_dig1_integer, hex2dig_dig2_integer, hex2dig_dig3_integer, hex2dig_dig4_integer, hex2dig_dig5_integer);
		end case;
	end process;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	hex2dig_data_logic_vector <= DATA;
	DIG0 <= hex2dig_dig0_integer;
	DIG1 <= hex2dig_dig1_integer;
	DIG2 <= hex2dig_dig2_integer;
	DIG3 <= hex2dig_dig3_integer;
	DIG4 <= hex2dig_dig4_integer;
	DIG5 <= hex2dig_dig5_integer;
end;