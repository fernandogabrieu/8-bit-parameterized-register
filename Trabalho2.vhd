-- Nome Projeto: Trabalho 2
-- Data: 13/04/23
-- Nome: FernandoGabriel/1688936

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Trabalho2 IS
	GENERIC (N : INTEGER := 6);
	PORT(KEY  : IN  STD_LOGIC_VECTOR(0 DOWNTO 0);
		  SW   : IN  STD_LOGIC_VECTOR(0 TO N+3); -- D(0-6) + Clear + Carga + Enable
		  LEDR : OUT STD_LOGIC_VECTOR(0 TO N)); -- Q(0-6)
		  
END ENTITY;

ARCHITECTURE reg_param OF Trabalho2 IS
	SIGNAL X : STD_LOGIC_VECTOR(0 TO N);
BEGIN

	GEN : FOR i IN 0 TO N GENERATE
		PROCESS(SW, KEY)
		BEGIN
			IF(SW(7) = '1') THEN -- Clear assíncrono
					X(i) <= '0';
				LEDR(i) <= '0';
			ELSIF (KEY'EVENT AND KEY(0) = '1' AND SW(8) = '1') THEN --Sinal de carga síncrono
				X(i) <= SW(i);
			END IF;	
			
			IF(SW(9) = '1') THEN -- Saida tristate
				LEDR(i) <= X(i);
			ELSIF (SW(9) = '0') THEN
				LEDR(i) <= 'Z';
			END IF;
			
		END PROCESS;
	END GENERATE GEN;
	
END ARCHITECTURE;
		  