

--UFRJ - 2021.1
--SISTEMAS DIGITAIS
--PROF: ROBERTO PACHECO
--ALUNOS: DANIEL SPIEGEL
--        YURI REIS
--PROJETO DE LABORATÓRIO 1

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY display IS 
	PORT (
		
		sel_ULA 		  : in STD_LOGIC_VECTOR (2 downto 0);
		x_ULA, y_ULA  : in STD_LOGIC_VECTOR (3 downto 0);
		saida_display : out STD_LOGIC_VECTOR (6 downto 0);
		x_display	  : out STD_LOGIC_VECTOR (6 downto 0);
		y_display	  : out STD_LOGIC_VECTOR (6 downto 0);
		nf_display, zf_display, cf_display, ovf_display	: out STD_LOGIC
		
		
		);
END display;

ARCHITECTURE final OF display IS

--Sinais da ULA

	signal nf_ULA, zf_ULA, cf_ULA, ovf_ULA : STD_LOGIC;
	signal output_ULA	  : STD_LOGIC_VECTOR (3 downto 0);

--Sinais do decodificador
	signal out_decodificador : STD_LOGIC_VECTOR(6 downto 0);
	signal x_decodificador   : STD_LOGIC_VECTOR (6 downto 0);
	signal y_decodificador   : STD_LOGIC_VECTOR(6 downto 0);
	
	COMPONENT ula 
	PORT(
		seletor : in STD_LOGIC_VECTOR (2 downto 0);				-- Valores para seleção 
		x : in STD_LOGIC_VECTOR (3 downto 0);						-- Entrada 4 bits
		y : in STD_LOGIC_VECTOR (3 downto 0);						-- Entrada 4 bits
		nf : out STD_LOGIC;												-- Declara flag valor negativo
		zf : out STD_LOGIC;												-- Declara flag saída zero
		cf : out STD_LOGIC;												-- Declara flag carry out
		ovf : out STD_LOGIC;												-- Declara flag overflow
		output : out STD_LOGIC_VECTOR (3 downto 0)				-- Saida 4 bits
		);
	END COMPONENT;

	COMPONENT decodificador
	PORT(
		x_decod : in STD_LOGIC_VECTOR(3 downto 0);				-- Entrada do decodificador
		y_decod : out STD_LOGIC_VECTOR(6 downto 0)				-- Saída decodificador
		);
	END COMPONENT;
	
	
BEGIN
	
	ula_0: ula PORT MAP(sel_ULA, x_ULA, y_ULA, nf_ULA, zf_ULA, cf_ULA, ovf_ULA, output_ULA);  --Chama a ULA e atribui os sinais
	decodout: decodificador PORT MAP (output_ULA, out_decodificador);                         --Decodifica a saída da ULa para o display de 7 segmentos
   decodx: decodificador PORT MAP (x_ULA, x_decodificador);												--Decodifica a entrada x da ULA para o dispaly de 7 segmentos
   decody: decodificador PORT MAP (y_ULA, y_decodificador);												--Decodifica a entrada y da ULA para o dispaly de 7 segmentos

-- Gera as saídas do bloco combinacional ULA+Decodificador+Display de sete segmentos

	saida_display <= out_decodificador;
	x_display 	  <= x_decodificador;
	y_display 	  <= y_decodificador;
	
	nf_display  <= nf_ULA;
	zf_display  <= zf_ULA;
	cf_display  <= cf_ULA;
	ovf_display <= ovf_ULA;
	
end final;