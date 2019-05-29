library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg32n is
	generic (N:		integer);
	port (
		CLOCK: 				in std_logic;
		DATA: 				in std_logic_vector (31 downto 0);
		WRITE_ADDRESS: 		in integer range 0 to N-1;
		A_READ_ADDRESS:		in integer range 0 to N-1;
		B_READ_ADDRESS:		in integer range 0 to N-1;
		WE: 				in std_logic;
		Q_A:				out std_logic_vector (31 downto 0);
		Q_B:				out std_logic_vector (31 downto 0)
	);
end entity;

architecture rtl of reg32n is
	type MEM is array (0 to N-1) of std_logic_vector(31 downto 0);
	signal reg32n_ram_core: MEM;

	-------------------------------------------------------------------
	-- REG32
	component reg32 is
		port (
			CLOCK: 				in std_logic;
			DATA: 				in std_logic_vector (31 downto 0);
			ENABLE: 			in std_logic;
			Q:					out std_logic_vector (31 downto 0)
		);
	end component;

	type reg32n_data_std_integer_array is array (N-1 downto 0) of integer;
	type reg32n_data_std_unsigned_array is array (N-1 downto 0) of Unsigned (31 downto 0);
	type reg32n_data_std_logic_vector_array is array (N-1 downto 0) of std_logic_vector (31 downto 0);

	type reg32n_q_std_integer_array is array (N-1 downto 0) of integer;
	type reg32n_q_std_unsigned_array is array (N-1 downto 0) of Unsigned (31 downto 0);
	type reg32n_q_std_logic_vector_array is array (N-1 downto 0) of std_logic_vector (31 downto 0);

	signal reg32n_clock_logic_vector: std_logic_vector (N-1 downto 0);

	signal reg32n_data_integer_array: reg32n_data_std_integer_array;
	signal reg32n_data_unsigned_array: reg32n_data_std_unsigned_array;
	signal reg32n_data_logic_vector_array: reg32n_data_std_logic_vector_array;

	signal reg32n_enable_logic_vector: std_logic_vector (N-1 downto 0);
	
	signal reg32n_q_integer_array: reg32n_q_std_integer_array;
	signal reg32n_q_unsigned_array: reg32n_q_std_unsigned_array;
	signal reg32n_q_logic_vector_array: reg32n_q_std_logic_vector_array;

begin
	--===============================================================--
	-- REG32n
	reg32n_bank: for i in N-1 downto 0 generate 
	-------------------------------------------------------------------
		reg32_vhd: reg32 	
				port map (
					CLOCK 					=> reg32n_clock_logic_vector(i),
					DATA 					=> reg32n_data_logic_vector_array(i),
					ENABLE					=> reg32n_enable_logic_vector(i),
					Q 						=> reg32n_q_logic_vector_array(i));

		reg32n_data_unsigned_array(i) <= Unsigned (reg32n_data_logic_vector_array(i));
		reg32n_data_integer_array(i) <= To_integer (reg32n_data_unsigned_array(i));

		reg32n_q_unsigned_array(i) <= Unsigned (reg32n_q_logic_vector_array(i));
		reg32n_q_integer_array(i) <= To_integer (reg32n_q_unsigned_array(i));
	-------------------------------------------------------------------		
	end generate reg32n_bank;

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	-- REG32n
	process(CLOCK)
	begin
		if (WE = '1') then	
			if CLOCK'event and CLOCK = '1' then
				Q_A <= reg32n_q_logic_vector_array(A_READ_ADDRESS);
				Q_B <= reg32n_q_logic_vector_array(B_READ_ADDRESS);
				reg32n_data_logic_vector_array(WRITE_ADDRESS) <= DATA;
			end if;
		end if;
	end process;

	reg32n_wire: for i in N-1 downto 0 generate
		reg32n_clock_logic_vector(i) <= CLOCK;
		reg32n_enable_logic_vector(i) <= WE;
	end generate reg32n_wire;
end;