-- a) Recuperar os nomes de clientes que não voaram para o Rio de Janeiro no dia 20/09/02.
SELECT CLI.NOME 
FROM CLIENTE_P CLI
INNER JOIN PASSAGEM PAS ON PAS.COD_CLI = CLI.COD_CLI
INNER JOIN EXECUCAO_VOO EXE ON EXE.NUM_VOO = PAS.NUM_VOO AND EXE.DATA = PAS.DATA
INNER JOIN VOO VOO ON VOO.NUM_VOO = EXE.NUM_VOO
WHERE VOO.CIDADE_CHEG <> 'Rio de Janeiro'
AND PAS.DATA <> '2002-09-20';

-- b) Para cada vôo que o piloto Paulo tenha comandado, recuperar a cidade de partida e a data do vôo,
-- bem como o número de passagens marcadas. Mostrar somente os vôos com menos de 500
-- passagens.
SELECT VOO.CIDADE_PART, EXE.DATA, PAS.num_voo, SUM(EXE.n_lugares)
FROM CLIENTE_P CLI
INNER JOIN PASSAGEM PAS ON PAS.COD_CLI = CLI.COD_CLI
INNER JOIN EXECUCAO_VOO EXE ON EXE.NUM_VOO = PAS.NUM_VOO AND EXE.DATA = PAS.DATA
INNER JOIN VOO VOO ON VOO.NUM_VOO = EXE.NUM_VOO
INNER JOIN PILOTO PIL ON PIL.COD_PILOTO = EXE.COD_PILOTO
WHERE PIL.NOME = 'Paulo'
AND EXE.n_lugares < 500
GROUP BY VOO.CIDADE_PART, EXE.DATA, PAS.num_voo;

-- c) Obter a cidade de partida e a data do último vôo que o piloto Paulo tenha comandado
SELECT VOO.CIDADE_PART, MAX(EXE.DATA)
FROM CLIENTE_P CLI
INNER JOIN PASSAGEM PAS ON PAS.COD_CLI = CLI.COD_CLI
INNER JOIN EXECUCAO_VOO EXE ON EXE.NUM_VOO = PAS.NUM_VOO AND EXE.DATA = PAS.DATA
INNER JOIN VOO VOO ON VOO.NUM_VOO = EXE.NUM_VOO
INNER JOIN PILOTO PIL ON PIL.COD_PILOTO = EXE.COD_PILOTO
WHERE PIL.NOME = 'Paulo'
GROUP BY VOO.CIDADE_PART
LIMIT 1;

-- d) Recuperar o código e nome de clientes que marcaram passagem em pelo menos todos os vôos
-- comandados pelo piloto Ronaldo, que saíram de Porto Alegre.
SELECT
	CLI.COD_CLI, CLI.NOME
FROM
	CLIENTE_P CLI
WHERE
NOT EXISTS (
	--Todo
	SELECT EXE.NUM_VOO 
	FROM EXECUCAO_VOO EXE
	INNER JOIN PILOTO PIL ON PIL.COD_PILOTO = EXE.COD_PILOTO
	INNER JOIN VOO VOO ON VOO.num_voo = EXE.NUM_VOO
	WHERE PIL.NOME = 'Ronaldo'
	AND VOO.CIDADE_PART = 'Porto Alegre'
	
	EXCEPT
	
	-- O que foi 'realizado'
	SELECT PAS.NUM_VOO
	FROM EXECUCAO_VOO EXE
	INNER JOIN PASSAGEM PAS ON PAS.num_voo = EXE.num_voo AND PAS.DATA = EXE.DATA
	WHERE
	PAS.COD_CLI = CLI.COD_CLI
);

-- e) Recuperar o código e nome de clientes que marcaram passagem em pelo menos todos os vôos
-- comandados pelo piloto Ronaldo, que saíram de Porto Alegre. Selecionar somente aqueles clientes
-- que tenham mais de uma passagem marcada até o final do ano em vôos ainda não executados.
SELECT
	CLI.COD_CLI, CLI.NOME
FROM
	CLIENTE_P CLI
WHERE
NOT EXISTS (
	--Todo
	SELECT EXE.NUM_VOO 
	FROM EXECUCAO_VOO EXE
	INNER JOIN PILOTO PIL ON PIL.COD_PILOTO = EXE.COD_PILOTO
	INNER JOIN VOO VOO ON VOO.num_voo = EXE.NUM_VOO
	WHERE PIL.NOME = 'Ronaldo'
	AND VOO.CIDADE_PART = 'Porto Alegre'
	
	EXCEPT
	
	-- O que foi 'realizado'
	SELECT PAS.NUM_VOO
	FROM EXECUCAO_VOO EXE
	INNER JOIN PASSAGEM PAS ON PAS.num_voo = EXE.num_voo AND PAS.DATA = EXE.DATA
	WHERE
	PAS.COD_CLI = CLI.COD_CLI
	-- Não entendi a ultima parte da questão d)
)
