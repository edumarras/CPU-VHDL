-- #P7i6 CPU 
-- EDUARDO A. MARRAS DE SOUZA RA: 20078408
-- BIANCA A. ANDRADE RA: 21007245
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY CPU IS
            PORT (DATAENT: IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- ENTRADA DE DADOS COMO ENTRADA DE 8 BITS
				CLOCK, W: IN STD_LOGIC;
				FUNC, RX, RY: IN STD_LOGIC_VECTOR(1 DOWNTO 0); -- INPUTS DO USUÁRIO DE 2 BITS 
				DONE: OUT STD_LOGIC; -- SINAL DE SAÍDA
				BARRAMENTO: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)); -- BARRAMENTO DO TIPO INOUT
END CPU;

ARCHITECTURE LOGIC OF CPU IS 
SIGNAL R0IN, R0T, R1IN, R1T, R2IN, R2T, R3IN, R3T, AIN, GIN, GOUT, ADDSUB, EXTERN: STD_LOGIC; -- SINAIS DA CPU

COMPONENT DATA -- DECLARAÇÃO DE COMPONENTES

				PORT (CLOCK, R0IN, R0T, R1IN, R1T, R2IN, R2T, R3IN, R3T, AIN, GIN, GOUT, ADDSUB, EXTERN : IN STD_LOGIC;
				DATAENT : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				BARRAMENTO : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0));
		
END COMPONENT;

COMPONENT CONTROL 

				PORT (W, CLOCK : IN STD_LOGIC;
				FUNC, RX, RY: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            R0IN, R0T, R1IN, R1T, R2IN, R2T, R3IN, R3T, AIN, GIN, GOUT, ADDSUB, EXTERN, DONE: OUT STD_LOGIC);
				
END COMPONENT;

BEGIN -- PORT MAP DE DATA LIGADA À UNIDADE DE CONTROLE DA CPU

PDATA: DATA PORT MAP(CLOCK, R0IN, R0T, R1IN, R1T, R2IN, R2T, R3IN, R3T, AIN, GIN, GOUT, ADDSUB, EXTERN, DATAENT, BARRAMENTO);
PCONTROL: CONTROL PORT MAP(W, CLOCK, FUNC, RX, RY, R0IN, R0T, R1IN, R1T, R2IN, R2T, R3IN, R3T, AIN, GIN, GOUT, ADDSUB, EXTERN, DONE);

END LOGIC;