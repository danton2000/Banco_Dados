CREATE OR REPLACE FUNCTION
TESTE1()
RETURN INT AS
$$
DECLARE -- coloca variaveis
BEGIN -- inicio de bloco do comando principal
RETURN;  -- deve ter para retorno de valor
END; -- fim do bloco principal
$$
--LANGUAGE 'PLpgSQL'; -- Definindo o tipo de função(Procedural)
LANGUAGE 'SQL'; -- Definindo o tipo de função(Escrita)

-- Tipo das funções:
-- Escrita
-- Procedural
-- Interna 
-- Em C

CREATE OR REPLACE FUNCTION LimparCurso()
RETURNS VOID AS '
    DELETE FROM CURSO;
'
LANGUAGE SQL;

SELECT * FROM CURSO;

-- EXECUTANDO A FUNÇÃO
SELECT LimparCurso();

CREATE OR REPLACE FUNCTION 
InsereMovimentos()
RETURNS VOID AS '
    insert into movimento values('ped1',1,20,53.00);
    insert into movimento values('ped1',3,15,29.70);
    insert into movimento values('ped1',4,10,15.40);
    insert into movimento values('ped2',4,12,18.48);
    insert into movimento values('ped2',3,10,19.80);
    insert into movimento values('ped3',1,15,39.75);
'
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION AtualizarMovimento(
    char(10),
    integer,
    integer
) RETURNS integer AS
$$

UPDATE MOVIMENTO 
SET QTDE = $3 
WHERE
NRO_PED = $1 
AND COD_PROD = $2;

SELECT 1;
$$

LANGUAGE SQL;

SELECT * FROM MOVIMENTO;

SELECT * FROM atualizrmovimento('ped1', 1, 50);

CREATE OR REPLACE FUNCTION AtualizarPrecoProduto(
    integer,
    decimal(5,2)
) RETURNS SETOF PRODUTO AS
$$

UPDATE PRODUTO
SET PRECO = PRECO * (1.00 + $2 / 100.00)
WHERE COD_PROD = $1;
--TERMINO DA FUNÇÃO
SELECT * FROM PRODUTO
WHERE COD_PROD = $1;

$$
LANGUAGE SQL;

SELECT * FROM PRODUTO
WHERE COD_PROD = 1

SELECT * FROM AtualizarPrecoProduto(1,50)

