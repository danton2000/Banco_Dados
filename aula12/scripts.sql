SELECT * FROM EX_MULTA;

CREATE OR REPLACE FUNCTION FN_DESCARTAR_RESULT( ) RETURNS VOID AS $$

DECLARE
	_MULTA EX_MULTA%ROWTYPE;

BEGIN
	-- EXECUTA O SELECT MAS DESCARTA O RESULTADO
	PERFORM * FROM EX_MULTA;
	-- VARIÁVEL QUE É LIGADA SE O COMANDO ANTERIOR (SELECT, UPDATE, INSERT, DELETE) AFETOU AO MENOS UMA LINHA
	-- VALIDA SE TEM LINHAS OU NÃO NA TABELA
	IF FOUND THEN
		RAISE NOTICE 'HÁ MULTAS CADASTRADAS NO SISTEMA';

	ELSE
		RAISE NOTICE 'NÃO HÁ MULTAS CADASTRADAS NO SISTEMA';
	END IF;
	RETURN;
END;
$$
LANGUAGE PLPGSQL;