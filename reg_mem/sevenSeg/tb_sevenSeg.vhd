library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_sevenSeeg is
end entity;

architecture waveform of tb_sevenSeeg is
	signal y: std_logic_vector(6 downto 0);
	signal x: std_logic_vector(3 downto 0);
	signal value: integer range 0 to 15;
	signal disp_mode: std_logic;
	    
    component seven_segment_ctrl is
    	generic (display_mode: std_logic);
		port (seg_in: in std_logic_vector (3  downto 0);
			  seg_out: out std_logic_vector (6 downto 0));   	
		end component;
		
begin

	x <= std_logic_vector(to_unsigned(value, 4));
	
	display_1: seven_segment_ctrl generic map 	(display_mode=> disp_mode)
								  port map		(seg_in => x,
												 seg_out => y);	
											
	disp_mode <= '0';
	
	process		
	begin
		if value > 7 then
			value <= 0;
		else
			value <= value + 1;
		end if;
		
		wait for 50 ns;	 
    end process;
 
end architecture;