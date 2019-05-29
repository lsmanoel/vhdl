library ieee;
use ieee.std_logic_1164.all;

entity sync_rom is
port (
	clock: in std_logic;
	address: in std_logic_vector(7 downto 0);
	data_out: out std_logic_vector(5 downto 0)
);
end sync_rom;

architecture rtl of sync_rom is
begin
	process (clock)
	begin
		if rising_edge (clock) then
			case address is
				when "00000000" => data_out <= "101111";
				when "00000001" => data_out <= "110110";
				when "11111110" => data_out <= "000001";
				when "11111111" => data_out <= "101010";
				when others => data_out <= "101111";
			end case;
		end if;
	end process;
end rtl;