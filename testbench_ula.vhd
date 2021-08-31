

--UFRJ - 2021.1
--SISTEMAS DIGITAIS
--PROF: ROBERTO PACHECO
--ALUNOS: DANIEL SPIEGEL
--        YURI REIS
--PROJETO DE LABORATÓRIO 1


--Entidade do teste de bancada não tem entradas e saídas

ENTITY testbench_ula IS END; 


LIBRARY IEEE;														 -- Biblioteca utilizada
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;


ARCHITECTURE tb_ula OF testbench_ula IS 

COMPONENT ula 
	
	PORT(
			seletor : in STD_LOGIC_VECTOR (2 downto 0);	 --Valores para seleção 
			x 		  : in STD_LOGIC_VECTOR (3 downto 0);	 --Entrada x 4 bits
			y 		  : in STD_LOGIC_VECTOR (3 downto 0);	 --Entrada y 4 bits
			nf 	  : out STD_LOGIC;							 --Declara flag valor negativo
			zf 	  : out STD_LOGIC;							 --Declara flag sada zero
			cf 	  : out STD_LOGIC;							 --Declara flag carry out
			ovf 	  : out STD_LOGIC;							 --Declara flag overflow
			output  : out STD_LOGIC_VECTOR (3 downto 0)	 --Saida 4 bits
			);
			
END COMPONENT;


-- SINAIS DE SELEÇÃO E ENTRADA DE VALORES
 
signal seletor_t : STD_LOGIC_VECTOR (2 downto 0);
signal x_t : STD_LOGIC_VECTOR (3 downto 0);		
signal y_t : STD_LOGIC_VECTOR (3 downto 0);			



BEGIN 

--Implementação da ULA usando mapeamento e deixando as saídas abertas pois não há sinal de ligação (queremos verificar o resultado gerado por elas)

ula1: ula PORT MAP( seletor => seletor_t , x => x_t, y => y_t , nf => open , zf => open , cf => open , ovf => open ,output => open);


--Implementação de varredura de resultados para teste de bancada usando processo de loop

estimulo: PROCESS

BEGIN 

WAIT FOR 5 ns; seletor_t <= "000"; x_t<= "0000"; y_t <= "0000";
FOR I IN 0 TO 7 LOOP
	WAIT FOR 1 ns;
	FOR U IN 0 TO 15 LOOP
		FOR W IN 0 TO 15 loop
		y_t <= y_t + "0001";
		WAIT FOR 1 ns;
		END LOOP;
	x_t <= x_t + "0001";
	WAIT FOR 1 ns;
	END LOOP;
	
seletor_t <= seletor_t + "001";

WAIT FOR 1 ns;
END LOOP;	

	
END PROCESS estimulo; 

END tb_ula;
