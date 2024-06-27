SELECT * FROM EX_MOTORISTA;

DROP FUNCTION fn_GeraMultas();

CREATE OR REPLACE FUNCTION fn_GeraMultas(
	CHAR(100),
	DECIMAL(8,2)
) RETURNS VOID AS
$$
<<bloco_externo>> --bloco nomeado

DECLARE
	-- Preparando as variaveis
	_cnh CHAR(100) := $1;
    _velocidade DECIMAL(8,2) := $2;
	_pontos INTEGER;
	_multa DECIMAL(8,2);
	_velocidade_calculada DECIMAL(8,2) := 90;
BEGIN
    RAISE NOTICE 'Quantidade aqui vale: %', _velocidade; --30
	
	-- VERIFICANDO SE O MOTORISTA EXISTE
	-- EXECUTA O SELECT MAS DESCARTA O RESULTADO
	PERFORM * FROM EX_MOTORISTA WHERE CNH = _cnh;
	-- VARIÁVEL QUE É LIGADA SE O COMANDO ANTERIOR (SELECT, UPDATE, INSERT, DELETE) AFETOU AO MENOS UMA LINHA
	-- VALIDA SE TEM LINHAS OU NÃO NA TABELA
	IF FOUND THEN
		RAISE NOTICE 'MOTORISTA ENCONTRADO NO SISTEMA';
		
		-- VERIFICACAO DA VELOCIDADE PARA APLICAR A MULTA AO MOTORISTA E PONTUAÇÃO
		IF _velocidade >= 80.01 and _velocidade <= 110 THEN
		
			_pontos := 20;
			_multa := 120.00;
			
		ELSIF _velocidade >= 110.01 and _velocidade <= 140 THEN
			
			_pontos := 40;
			_multa := 350;
			
		ELSIF _velocidade > 140 THEN
			_pontos := 60;
			_multa := 680;
			
		ELSE
			_pontos := 0;
			_multa := 0;
		END IF;

		RAISE NOTICE 'A multa foi: %', _multa;
		
		INSERT INTO EX_MULTA (
			CNH,
			VELOCIDADEAPURADA,
			VELOCIDADECALCULADA,
			PONTOS,
			VALOR
		) VALUES (
			_cnh,
			_velocidade,
			_velocidade_calculada,
			_pontos,
			_multa
		);
	
	ELSE
		RAISE NOTICE 'MOTORISTA NÃO ENCONTRADO NO SISTEMA';
	END IF;
    
RETURN;

END;

$$ LANGUAGE plpgsql;

SELECT * FROM fn_GeraMultas('123AB', 120.2);

SELECT * FROM EX_MULTA;

CREATE FUNCTION fn_GeraMultas(
	CHAR(100)
) RETURNS VOID AS
$$
-- FUNÇÃO PARA ATUALIZAR A MULTA(SOMATORIO)