

--UFRJ - 2021.1
--SISTEMAS DIGITAIS
--PROF: ROBERTO PACHECO
--ALUNOS: DANIEL SPIEGEL
--        YURI REIS
--PROJETO DE LABORATÓRIO 1


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

--Implementação de um decodificador binário-7 segmentos

ENTITY decodificador IS
	PORT(
		x_decod : in STD_LOGIC_VECTOR(3 downto 0);
		y_decod : out STD_LOGIC_VECTOR(6 downto 0)
		);
END decodificador;

ARCHITECTURE decod OF decodificador IS


signal y_dec : STD_LOGIC_VECTOR(6 downto 0);             --Sinal temporário 

BEGIN
	PROCESS(x_decod)
	
--Lógica do decodificador implementando a tabela verdade
	
	BEGIN
		CASE x_decod IS
		        when "0000"=> y_dec <="0111111";
				  when "0001"=> y_dec <="0110000";
              when "0010"=> y_dec <="1101101";
              when "0011"=> y_dec <="1111001";
              when "0100"=> y_dec <="1110010";
              when "0101"=> y_dec <="1011011";
              when "0110"=> y_dec <="1011111";
              when "0111"=> y_dec <="0110001";
              when "1000"=> y_dec <="1111111";
              when "1001"=> y_dec <="1111011";
              when "1010"=> y_dec <="1110111";
              when "1011"=> y_dec <="1011110";
              when "1100"=> y_dec <="0001111";
              when "1101"=> y_dec <="1111100";
              when "1110"=> y_dec <="1001111";
              when "1111"=> y_dec <="1000111";
              when others=> y_dec <="0000000";
		END CASE;
	END PROCESS;
	
--Negação do decodificador, pois o CI possui entrada negada

	y_decod <=not y_dec;

END decod;
