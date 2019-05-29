library ieee;
use ieee.std_logic_1164.all;

entity int2dig is
	port(
		DATA: in integer;
		DIG0: out integer range 0 to 31;
		DIG1: out integer range 0 to 31;
		DIG2: out integer range 0 to 31;
		DIG3: out integer range 0 to 31;
		DIG4: out integer range 0 to 31;
		DIG5: out integer range 0 to 31
	);
end;

architecture rtl of int2dig is
begin
	process(DATA)
		variable buffer_integer_var: integer;

	begin

		buffer_integer_var:=DATA;

		DIG0 <= 1;
		DIG1 <= 1;
		DIG2 <= 1;
		DIG3 <= 1;
		DIG4 <= 1;
		DIG5 <= 1;

		DIG0 <= buffer_integer_var MOD 10;--0
		buffer_integer_var:=buffer_integer_var/10;

		IF (buffer_integer_var > 9) THEN

			DIG1<=buffer_integer_var MOD 10;--1
			buffer_integer_var:=buffer_integer_var/10;

			IF (buffer_integer_var > 9) THEN

				DIG2<=buffer_integer_var MOD 10;--2
				buffer_integer_var:=buffer_integer_var/10;

				IF (buffer_integer_var > 9) THEN

					DIG3<=buffer_integer_var MOD 10;--3
					buffer_integer_var:=buffer_integer_var/10;

					IF (buffer_integer_var > 9) THEN

						DIG4<=buffer_integer_var MOD 10;--4
						buffer_integer_var:=buffer_integer_var/10;

						IF (buffer_integer_var > 9) THEN

							DIG5<=buffer_integer_var MOD 10;--5
							buffer_integer_var:=buffer_integer_var/10;

						ELSE
							DIG5<=buffer_integer_var;

						END IF;
					ELSE
						DIG4<=buffer_integer_var;

					END IF;
				ELSE
					DIG3<=buffer_integer_var;

				END IF;
			ELSE
				DIG2<=buffer_integer_var;

			END IF;
		ELSE
			DIG1<=buffer_integer_var;

		END IF;
	end process;
end;