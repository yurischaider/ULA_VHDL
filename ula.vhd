

--UFRJ - 2021.1
--SISTEMAS DIGITAIS
--PROF: ROBERTO PACHECO
--ALUNOS: DANIEL SPIEGEL
--        YURI REIS
--PROJETO DE LABORATÓRIO 1

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;

ENTITY ula IS
	PORT(
			seletor	:	in	STD_LOGIC_VECTOR (2 downto 0);		-- Seletor de operao
			x			:	in	STD_LOGIC_VECTOR (3 downto 0);		-- Entrada x de 4 bits
			y			:	in	STD_LOGIC_VECTOR (3 downto 0);		-- Entrada y de 4 bits
			nf			:	out STD_LOGIC;									-- Flag valor negativo
			zf			:	out STD_LOGIC;									-- Flag sada zero
			cf			:	out STD_LOGIC;									-- Flag Carry out
			ovf		:	out STD_LOGIC;									-- Flag Overflow
			output	:	out STD_LOGIC_VECTOR (3 downto 0)
			);
END ula;

ARCHITECTURE hardware OF ula IS
BEGIN

PROCESS(x,y,seletor)

VARIABLE var: STD_LOGIC_VECTOR (4 downto 0);				-- Variavel para receber a operao
VARIABLE outputv: STD_LOGIC_VECTOR (3 downto 0);		-- variavel temporaria de saida
VARIABLE cfv, zfv: STD_LOGIC;									-- variavel temporaria das flags de carry e zero

BEGIN
	cf  <= '0';
	ovf <= '0';
	var := "00000";
	zfv := '0';
	
	CASE seletor IS
	
		WHEN "000" =>												-- Operação soma A + B
			var := ('0' & x) + ('0' & y);
			outputv := var(3 downto 0);
			cfv := var(4);
			ovf <= outputv(3) xor x(3) xor y(3) xor cfv;
			cf <= cfv;
			
		WHEN "001" =>							               -- Operação subtração A - B com complemento de 2
			var := ('0' & x) + (not('0' & y) + "00001");
			outputv := var(3 downto 0);
			cfv := var(4);
			ovf <= outputv(3) xor x(3) xor y(3) xor cfv;
			cf <= cfv;
			
		WHEN "010" =>							               -- Operação subtração B - A com complemento de 2
			var := ('0' & y) + (not('0' & x) + "00001");
			outputv := var(3 downto 0);
			cfv := var(4);
			ovf <= outputv(3) xor x(3) xor y(3) xor cfv;
			cf <= cfv;
			
		WHEN "011" =>							               -- Operação incremento +1
			var := ('0' & x) + "00001";
			outputv := var(3 downto 0);
			cfv := var(4);
			ovf <= outputv(3) xor x(3) xor cfv;
			cf <= cfv;
			
		WHEN "100" =>							               -- Operação Complemento de 2
			var := not('0' & x) + "0001";
			outputv := var(3 downto 0);
			cfv := var(4);
			ovf <= outputv(3) xor x(3) xor cfv;
			cf <= cfv;
			
		WHEN "101" =>							               -- Operaçãoo AND
			outputv := x and y;
			
		WHEN "110" =>							               -- Operação OR
			outputv := x or y;
			
		WHEN "111" =>							               -- Operação XOR
			outputv := x xor y;
			
		WHEN OTHERS =>
			outputv := x;
			
	END CASE;
	
	FOR i IN 0 to 3 LOOP
	
		zfv := zfv or outputv(i);					         -- zfv ser 0 se o outputv(i) for 0
	
	END LOOP;
	
	output <= outputv;
	zf <= not zfv;
	
	IF (x=y and (seletor = "001" or seletor = "010")) THEN
		
		nf <= '0';
	
	ELSE nf <= outputv(3);
	END IF;

END PROCESS;

END hardware;
