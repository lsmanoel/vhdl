library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_reg3232 is
end entity;

architecture waveform of tb_reg3232 is
	-------------------------------------------------------------------
	-- CLOCK
	signal clock_50_0_logic, clock_50_PI_logic: std_logic;

	-------------------------------------------------------------------
	-- DATA
	signal data_integer: integer:=0;
	signal data_unsigned: Unsigned (31 downto 0);
	signal data_logic_vector: std_logic_vector (31 downto 0);

	-------------------------------------------------------------------
	-- WR_ADDRESS
	signal write_address_integer: integer range 0 to 31:=0;
	signal read_address_integer: integer range 0 to 31:=0;
	signal wr_address_unsigned: Unsigned (9 downto 0);
	signal wr_address_logic_vector: std_logic_vector (9 downto 0);

	-------------------------------------------------------------------
	-- WE
	signal we_logic: std_logic;

	-------------------------------------------------------------------
	-- Q
	signal q_integer: integer:=0;
	signal q_unsigned: Unsigned (31 downto 0);
	signal q_logic_vector: std_logic_vector (31 downto 0);

	-------------------------------------------------------------------
	-- REG3232
	component reg3232 is
		port 	(CLOCK: 				in std_logic;
				 DATA: 					in std_logic_vector (31 downto 0);
				 WRITE_ADDRESS: 		in integer range 0 to 31;
				 READ_ADDRESS: 			in integer range 0 to 31;
				 WE: 					in std_logic;
				 Q:						out std_logic_vector (31 downto 0));
	end component;

	signal reg3232_clock_logic: std_logic;
	signal reg3232_we_logic: std_logic;

	signal reg3232_data_integer: integer:=0;
	signal reg3232_data_unsigned: Unsigned (31 downto 0);
	signal reg3232_data_logic_vector: std_logic_vector (31 downto 0);

	signal reg3232_write_address_integer: integer range 0 to 31:=0;
	signal reg3232_write_address_unsigned: Unsigned (4 downto 0);
	signal reg3232_write_address_logic_vector: std_logic_vector(4 downto 0);

	signal reg3232_read_address_integer: integer range 0 to 31:=0;
	signal reg3232_read_address_unsigned: Unsigned (4 downto 0);
	signal reg3232_read_address_logic_vector: std_logic_vector (4 downto 0);

	signal reg3232_q_integer: integer:=0;
	signal reg3232_q_unsigned: Unsigned (31 downto 0);
	signal reg3232_q_logic_vector: std_logic_vector (31 downto 0);

begin
	--===============================================================--
	-- CLOCK
	CLOCK_50_0: process -- 50 MHz phase 0
	begin
		clock_50_0_logic <= '1';
		wait for 10 ns;
		clock_50_0_logic <= '0';
		wait for 10 ns;
	end process;

	CLOCK_50_PI: process -- 50 MHz phase pi
	begin
		clock_50_PI_logic <= '0';
		wait for 10 ns;
		clock_50_PI_logic <= '1';
		wait for 10 ns;
	end process;

	--===============================================================--
	-- WR_ADDRESS: process
	-- begin
	-- 	w_address_integer <= w_address_integer + 1;
	-- 	r_address_integer <= r_address_integer + 1;
	-- 	wait for 10 ns;
	-- end process;

	write_address_integer <= 1;
	read_address_integer <= 1;

	wr_address_unsigned <= To_unsigned(write_address_integer, 5)&To_unsigned(read_address_integer, 5);	
	wr_address_logic_vector	<= Std_logic_vector(wr_address_unsigned);

	--===============================================================--
	-- WE: process
	-- begin
	-- 	we_logic <= '0';
	-- 	wait for 10 ns;
	-- 	we_logic <= '1';
	-- 	wait for 10 ns;
	-- end process;

	we_logic <= '1';

	--===============================================================--
	DATA: process
	begin
		if data_integer > 16 then
			data_integer <= 0;
		else
			data_integer <= data_integer - 1;
		end if;
		wait for 66 ns;
	end process;

	data_unsigned <= To_unsigned(data_integer, 32);	
	data_logic_vector	<= Std_logic_vector(data_unsigned);

	--===============================================================--
	-- Q
	q_unsigned <= Unsigned(q_logic_vector);
	q_integer <= To_integer(q_unsigned);

	--===============================================================--
	reg3232_vhd: reg3232
			port map (
				CLOCK 					=> reg3232_clock_logic,
				DATA 					=> reg3232_data_logic_vector,
				WRITE_ADDRESS 			=> reg3232_write_address_integer,
				READ_ADDRESS 			=> reg3232_read_address_integer,
				WE 						=> reg3232_we_logic,
				Q 						=> reg3232_q_logic_vector);
	
	reg3232_data_unsigned <= Unsigned(reg3232_data_logic_vector);
	reg3232_data_integer <= To_integer(reg3232_data_unsigned);

	reg3232_write_address_unsigned <= To_unsigned(reg3232_write_address_integer, 5);
	reg3232_write_address_logic_vector <= Std_logic_vector(reg3232_write_address_unsigned);

	reg3232_read_address_unsigned <= To_unsigned(reg3232_read_address_integer, 5);
	reg3232_read_address_logic_vector <= Std_logic_vector(reg3232_read_address_unsigned);

	reg3232_q_unsigned <= Unsigned(reg3232_q_logic_vector);
	reg3232_q_integer <= To_integer(reg3232_q_unsigned);

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	reg3232_clock_logic <= clock_50_0_logic;

	reg3232_data_logic_vector <= data_logic_vector; 

	reg3232_write_address_integer <= write_address_integer;

	reg3232_read_address_integer <= read_address_integer;

	reg3232_we_logic <= we_logic;

	q_logic_vector <= reg3232_q_logic_vector;

end architecture;