library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_sevenSeg is
end entity;

architecture waveform of tb_sevenSeg is
	-------------------------------------------------------------------
	-- DATA
	signal data_integer: integer:=0;
	signal data_unsigned: Unsigned (3 downto 0);
	signal data_logic_vector: std_logic_vector (3 downto 0);

	-------------------------------------------------------------------
	-- Q
	signal q_integer: integer;
	signal q_unsigned: Unsigned (6 downto 0);
	signal q_logic_vector: std_logic_vector (6 downto 0);

	-------------------------------------------------------------------
	-- SEVENSEG
    component sevenSeg is
		generic (DISPLAY_MODE: std_logic := '0');
		port (DATA: in std_logic_vector (3 downto 0);
			  Q: out std_logic_vector (6 downto 0));
	end component;

	signal sevenSeg_data_integer: integer;
	signal sevenSeg_data_unsigned: Unsigned(3 downto 0);
	signal sevenSeg_data_logic_vector: std_logic_vector(3 downto 0);

	signal sevenSeg_q_integer: integer;
	signal sevenSeg_q_unsigned: Unsigned(6 downto 0);
	signal sevenSeg_q_logic_vector: std_logic_vector(6 downto 0);

begin
	--===============================================================--
	DATA: process
	begin
		if data_integer > 3 then
			data_integer <= 0;
		else
			data_integer <= data_integer + 1;
		end if;
		wait for 66 ns;
	end process;

	data_unsigned <= To_unsigned(data_integer, 4);	
	data_logic_vector	<= Std_logic_vector(data_unsigned);

	--===============================================================--
	-- Q
	q_unsigned <= Unsigned(q_logic_vector);
	q_integer <= To_integer(q_unsigned);

	--===============================================================--
	sevenSeg_vhd: sevenSeg 	
		generic map 	(DISPLAY_MODE 	=> '1')
		port map		(DATA 			=> sevenSeg_data_logic_vector,
							Q 			=> sevenSeg_q_logic_vector);	
	
	sevenSeg_data_unsigned <= Unsigned(sevenSeg_data_logic_vector);
	sevenSeg_data_integer <= To_integer(sevenSeg_data_unsigned);

	sevenSeg_q_unsigned <= Unsigned(sevenSeg_q_logic_vector);
	sevenSeg_q_integer <= To_integer(sevenSeg_q_unsigned);

	--&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&--
	sevenSeg_data_logic_vector <= data_logic_vector;

	q_logic_vector <= sevenSeg_q_logic_vector;	

end architecture;