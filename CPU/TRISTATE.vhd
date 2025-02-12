-- #P7i6 TRISTATE
-- EDUARDO A. MARRAS DE SOUZA RA: 20078408
-- BIANCA A. ANDRADE RA: 21007245
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY TRISTATE IS
            PORT (INPUT : IN STD_LOGIC_VECTOR(7 DOWNTO 0); -- ENTRADA DO TRISTATE COM ESPAÇO PARA 8 BITS 
            ENABLE: IN STD_LOGIC; -- ENABLE DE ATIVAÇÃO
            OUTPUT     : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); -- SAÍDA DO TRISTATE COM ESPAÇO PARA 8 BITS
END TRISTATE;

ARCHITECTURE LOGIC OF TRISTATE IS

BEGIN

        OUTPUT <= INPUT WHEN ENABLE = '1' else "ZZZZZZZZ"; -- QUANDO ATIVADO O ENABLE, SAÍDA RECEBE ENTRADA. SENÃO, ALTA IMPEDÂNCIA

END LOGIC;