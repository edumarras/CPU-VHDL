-- #P7i6 Controlador
-- EDUARDO A. MARRAS DE SOUZA RA: 20078408
-- BIANCA A. ANDRADE RA: 21007245
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CONTROL IS
            PORT (W, CLOCK : IN STD_LOGIC; -- W E CLOCK SENDO ENTRADAS COMUNS
				FUNC, RX, RY: IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- ENTRADAS DE 2 BITS (OPCODE)
            R0IN, R0T, R1IN, R1T, R2IN, R2T, R3IN, R3T, AIN, GIN, GOUT, ADDSUB, EXTERN, DONE: OUT STD_LOGIC); -- SAÍDAS COMUNS PARA CONTROLE
END CONTROL;

ARCHITECTURE LOGIC OF CONTROL IS
TYPE STAGE IS (S0, S1, S2, S3, S4, S5, S6, S7, S8); -- DECLARAÇÃO DOS ESTADOS PARA A MÁQUINA DE ESTADOS
SIGNAL CST, NST: STAGE; -- SINAIS PARA O CONTROLADOR

BEGIN

	PROCESS (FUNC, RX, RY, W, CST)

BEGIN

	CASE CST IS 
WHEN S0 => -- INPUT DE UPCODE DO USUÁRIO (MENU)
	IF FUNC = "00" THEN -- SELECIONA LOAD
	NST <= S1;
	ELSIF FUNC = "01" THEN -- SELECIONA MOV
	NST <= S2;
	ELSIF FUNC = "10" THEN -- SELECIONA ADD
	NST <= S3;
	ELSIF FUNC = "11" THEN -- SELECIONA SUB
	NST <= S4;
	END IF;
	
WHEN S1 => -- FUNÇÃO LOAD
R0IN <= '0'; R0T <= '0'; R1IN <= '0'; R1T <= '0'; R2IN <= '0'; R2T <= '0'; R3IN <= '0'; R3T <= '0';
AIN <= '0'; GIN <= '0'; GOUT <= '0'; ADDSUB <= '0'; EXTERN <= '0'; DONE <= '0'; -- INICIALIZAÇÃO DA FUNÇÃO 

   R0T <= '0';
	R1T <= '0';
	R2T <= '0';			
	R3T <= '0';

-- USUÁRIO SELECIONA O REGISTRADOR ONDE O DATA SERÁ ARMAZENADO
	
	IF RX = "00" THEN -- Seleciona o Registrador 0
	R0IN <=  '1';
	R1IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	ELSIF RX = "01" THEN -- Seleciona o Registrador 1
	R1IN <= '1';
	R0IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	ELSIF RX = "10" THEN -- Seleciona o Registrador 2
	R2IN <= '1';
	R1IN <= '0';
	R3IN <= '0';
	R0IN <= '0';
	ELSE -- Seleciona o Registrador 3
	R3IN <= '1';
	R1IN <= '0';
	R2IN <= '0';
	R0IN <= '0';
	END IF;

	EXTERN <= '1'; -- ATIVA TRISTATE DO DATA
	NST <= S0; -- PRÓXIMO ESTADO SERÁ S0
	DONE <= '1'; -- ENCERRA FUNÇÃO
	
WHEN S2 => -- FUNÇÃO MOVE
R0IN <= '0'; R0T <= '0'; R1IN <= '0'; R1T <= '0'; R2IN <= '0'; R2T <= '0'; R3IN <= '0'; R3T <= '0';
AIN <= '0'; GIN <= '0'; GOUT <= '0'; ADDSUB <= '0'; EXTERN <= '0'; DONE <= '0'; -- INICIALIZAÇÃO DA FUNÇÃO

-- USUÁRIO SELECIONA O REGISTRADOR DO QUAL SERÁ EXTRAÍDO O DADO

	IF RY = "00" THEN -- Seleciona o Registrador 0
	R0T <= '1';
	R1T <= '0'; 
	R2T <= '0';
	R3T <= '0';
	ELSIF RY = "01" THEN -- Seleciona o Registrador 1
	R1T <= '1';
	R0T <= '0';
	R2T <= '0';
	R3T <= '0';
	ELSIF RY = "10" THEN -- Seleciona o Registrador 2
	R2T <= '1';
	R0T <= '0';
	R1T <= '0';
	R3T <= '0';
	ELSE -- Seleciona o Registrador 3
	R3T <= '1';
	R0T <= '0';
	R1T <= '0';
	R2T <= '0';
	END IF;
	
-- USUÁRIO SELECIONA O REGISTRADOR PARA ONDE VAI O DADO

	IF RX = "00" THEN -- Seleciona o Registrador 0
	R0IN <=  '1';
	R1IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	ELSIF RX = "01" THEN -- Seleciona o Registrador 1
	R1IN <= '1';
	R0IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	ELSIF RX = "10" THEN -- Seleciona o Registrador 2
	R2IN <= '1';
	R1IN <= '0';
	R3IN <= '0';
	R0IN <= '0';
	ELSE -- Seleciona o Registrador 3
	R3IN <= '1';
	R1IN <= '0';
	R2IN <= '0';
	R0IN <= '0';
	END IF;
	
	NST <= S0; -- PRÓXIMO ESTADO SERÁ S0
	DONE <= '1'; -- ENCERRA FUNÇÃO
	
WHEN S3 => -- FUNÇÃO SOMA (1/3)
R0IN <= '0'; R0T <= '0'; R1IN <= '0'; R1T <= '0'; R2IN <= '0'; R2T <= '0'; R3IN <= '0'; R3T <= '0';
AIN <= '0'; GIN <= '0'; GOUT <= '0'; ADDSUB <= '0'; EXTERN <= '0'; DONE <= '0'; -- INICIALIZAÇÃO DA FUNÇÃO

-- SELECIONA INICIALMENTE QUAL O PRIMEIRO REGISTRADOR PARA ADICIONAR (1 CLOCK)

	IF RX = "00" THEN -- Seleciona o Registrador 0
	R0T <= '1';
	R1T <= '0'; 
	R2T <= '0';
	R3T <= '0';
	ELSIF RX = "01" THEN -- Seleciona o Registrador 1
	R1T <= '1';
	R0T <= '0';
	R2T <= '0';
	R3T <= '0';
	ELSIF RX = "10" THEN -- Seleciona o Registrador 2
	R2T <= '1';
	R0T <= '0';
	R1T <= '0';
	R3T <= '0';
	ELSE -- Seleciona o Registrador 3
	R3T <= '1';
	R0T <= '0';
	R1T <= '0';
	R2T <= '0';
	END IF;
	
	R0IN <= '0';
	R1IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	
	ADDSUB <= '0'; -- CÓDIGO DA ADIÇÃO
	AIN <= '1'; -- ABRE O REGISTRADOR DE PROPÓSITO ESPECÍFICO 'A'
	NST <= S5; -- PRÓXIMO ESTADO SERÁ S5
	DONE <= '0'; -- AINDA NÃO ENCERRA FUNÇÃO
	
WHEN S5 => -- FUNÇÃO SOMA (2/3)

-- SELECIONA O SEGUNDO REGISTRADOR PARA A SOMA

	IF RY = "00" THEN -- Seleciona o Registrador 0
	R0T <= '1';
	R1T <= '0'; 
	R2T <= '0';
	R3T <= '0';
	ELSIF RY = "01" THEN -- Seleciona o Registrador 1
	R1T <= '1';
	R0T <= '0';
	R2T <= '0';
	R3T <= '0';
	ELSIF RY = "10" THEN -- Seleciona o Registrador 2
	R2T <= '1';
	R0T <= '0';
	R1T <= '0';
	R3T <= '0';
	ELSE -- Seleciona o Registrador 3
	R3T <= '1';
	R0T <= '0';
	R1T <= '0';
	R2T <= '0';
	END IF;
	
	R0IN <= '0';
	R1IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	
	ADDSUB <= '0'; -- CÓDIGO DA ADIÇÃO
	GIN <= '1'; -- ABRE G
	NST <= S6; -- PRÓXIMO ESTADO SERÁ S6
	DONE <= '0'; -- AINDA NÃO ENCERRA FUNÇÃO
	
WHEN S6 => -- FUNÇÃO SOMA (3/3)

-- SELECIONA O REGISTRADOR NO QUAL SERÁ ARMAZENADA A SOMA

	IF RX = "00" THEN -- Seleciona o Registrador 0
	R0IN <=  '1';
	R1IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	ELSIF RX = "01" THEN -- Seleciona o Registrador 1
	R1IN <= '1';
	R0IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	ELSIF RX = "10" THEN -- Seleciona o Registrador 2
	R2IN <= '1';
	R1IN <= '0';
	R3IN <= '0';
	R0IN <= '0';
	ELSE -- Seleciona o Registrador 3
	R3IN <= '1';
	R1IN <= '0';
	R2IN <= '0';
	R0IN <= '0';
	END IF;
	
	R0T <= '0';
	R1T <= '0';
	R2T <= '0';
	R3T <= '0';
	
	GIN <= '0'; -- ZERADO NOVAMENTE
	GOUT <= '1'; -- ABRE O REGISTRADOR DE PROPÓSITO ESPECÍFICO 'G' 
	AIN <= '0'; -- ZERADO NOVAMENTE
	NST <= S0; -- PRÓXIMO ESTADO SERÁ S0
	DONE <= '1'; -- ENCERRA A SOMA
	
WHEN S4 => -- FUNÇÃO SUBTRAÇÃO (1/3)

-- SELECIONA INICIALMENTE QUAL O PRIMEIRO REGISTRADOR PARA SUBTRAIR (1 CLOCK)

	IF RX = "00" THEN -- Seleciona o Registrador 0
	R0T <= '1';
	R1T <= '0'; 
	R2T <= '0';
	R3T <= '0';
	ELSIF RX = "01" THEN -- Seleciona o Registrador 1
	R1T <= '1';
	R0T <= '0';
	R2T <= '0';
	R3T <= '0';
	ELSIF RX = "10" THEN -- Seleciona o Registrador 2
	R2T <= '1';
	R0T <= '0';
	R1T <= '0';
	R3T <= '0';
	ELSE -- Seleciona o Registrador 3
	R3T <= '1';
	R0T <= '0';
	R1T <= '0';
	R2T <= '0';
	END IF;
	
	R0IN <= '0';
	R1IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	
	AIN <= '1'; -- ABRE O REGISTRADOR DE PROPÓSITO ESPECÍFICO 'A'
	ADDSUB <= '1'; -- CÓDIGO DA SUBTRAÇÃO
	NST <= S7; -- PRÓXIMO ESTADO SERÁ S7
	DONE <= '0'; -- AINDA NÃO ENCERROU A SUBTRAÇÃO
	
WHEN S7 => -- FUNÇÃO SUBTRAÇÃO (2/3)

-- SEGUNDO CLOCK 

	IF RY = "00" THEN -- Seleciona o Registrador 0
	R0T <= '1';
	R1T <= '0'; 
	R2T <= '0';
	R3T <= '0';
	ELSIF RY = "01" THEN -- Seleciona o Registrador 1
	R1T <= '1';
	R0T <= '0';
	R2T <= '0';
	R3T <= '0';
	ELSIF RY = "10" THEN -- Seleciona o Registrador 2
	R2T <= '1';
	R0T <= '0';
	R1T <= '0';
	R3T <= '0';
	ELSE -- Seleciona o Registrador 3
	R3T <= '1';
	R0T <= '0';
	R1T <= '0';
	R2T <= '0';
	END IF;
	
	R0IN <= '0';
	R1IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	
	AIN <= '0'; 
	ADDSUB <= '1'; -- CÓDIGO DA SUBTRAÇÃO
	GIN <= '1'; -- ABRE 'G'
	NST <= S8; -- PRÓXIMO ESTADO SERÁ S8
	DONE <= '0'; -- AINDA NÃO ENCERRA FUNÇÃO
	
WHEN S8 => -- FUNÇÃO SUBTRAÇÃO (3/3)

-- ÚLTIMO CLOCK

	IF RX = "00" THEN -- Seleciona o Registrador 0
	R0IN <=  '1';
	R1IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	ELSIF RX = "01" THEN -- Seleciona o Registrador 1
	R1IN <= '1';
	R0IN <= '0';
	R2IN <= '0';
	R3IN <= '0';
	ELSIF RX = "10" THEN -- Seleciona o Registrador 2
	R2IN <= '1';
	R1IN <= '0';
	R3IN <= '0';
	R0IN <= '0';
	ELSE -- Seleciona o Registrador 3
	R3IN <= '1';
	R1IN <= '0';
	R2IN <= '0';
	R0IN <= '0';
	END IF;
	
	R0T <= '0';
	R1T <= '0';
	R2T <= '0';
	R3T <= '0';
	
	AIN <= '0';
	GOUT <= '1'; -- PERMITE SAÍDA DO CONTEÚDO DE 'G'
	ADDSUB <= '1'; -- CÓDIGO DA SUBTRAÇÃO
	NST <= S0; -- PRÓXIMO ESTADO SERÁ S0
	DONE <= '1'; -- ENCERRA SUBTRAÇÃO
	
	END CASE;

END PROCESS;

	PROCESS(CLOCK)
	
	BEGIN 
	
	IF CLOCK'EVENT AND CLOCK = '1' THEN -- NA SUBIDA DO CLOCK, ESTADO ATUAL SE TORNA O PRÓXIMO ESTADO
	CST <= NST;
	END IF;

END PROCESS;


END LOGIC;
