DROP FUNCTION FN_EXEMPLO_A();

CREATE OR REPLACE FUNCTION FN_EXEMPLO_A() RETURNS CHAR(50) AS
$$
<<bloco_externo>> --bloco nomeado

DECLARE
    _qtd INTEGER := 30;

BEGIN
    RAISE NOTICE 'Quantidade aqui vale: %', _qtd; --30

    _qtd := 50;

    --******
    -- SUB BLOCO
    --******

    DECLARE
        _qtd INTEGER := 80;

    BEGIN
        RAISE NOTICE 'Quantidade (interno) aqui vale: %', _qtd; --80
        RAISE NOTICE 'Quantidade (externo) aqui vale: %', bloco_externo._qtd; --50
    END;

    RAISE NOTICE 'Quantidade (externo) aqui vale: %', _qtd;--50
	
RETURN 'Valor de Saida ' || _qtd; --Concatenando

END;

$$ LANGUAGE plpgsql;

SELECT FN_EXEMPLO_A();

-- DROP FUNCTION FN_EXEMPLO_PARAMETROS(
--     in_a INTEGER,
--     in_b INTEGER);


CREATE OR REPLACE FUNCTION FN_EXEMPLO_PARAMETROS(
    in_a DECIMAL(8,2),
    in_b DECIMAL(8,2)
) RETURNS DECIMAL(8,2) AS
$$

DECLARE
    _result DECIMAL(8,2);

BEGIN

    RAISE NOTICE 'Mostrando os valores de parametros:% e %', in_a, in_b;

    _result := in_a / in_b;

RETURN _result;

END;

$$ LANGUAGE plpgsql;

SELECT FN_EXEMPLO_PARAMETROS(100,3); --33,33

CREATE OR REPLACE FUNCTION FN_EXEMPLO_TIPOS(
    p_cod_cli INTEGER
) RETURNS VARCHAR(50) AS
$$

DECLARE 
    _cliente cliente%ROWTYPE; -- Registro do tipo cliente (possui todas as colunas da tabela cliente e irá armazenas um linha)

    _cod_cli cliente.cod_cli%TYPE;

    _msg VARCHAR(80);

BEGIN
    -- Jogando o resultado no _cliente
    SELECT * INTO _cliente FROM cliente WHERE cod_cli = p_cod_cli

    RAISE NOTICE '%', 'Atribbui um valor a variavel do tipo type';

    _cod_cli := 'c1';

    IF cod_cli - cliente.cod_cli THEN
        RAISE NOTICE '%', 'Se cliente for igual a c3 listar o nome do cliente c1';

        _msg := 'Cliente já existe';

        SELECT * INTO _cliente FROM cliente WHERE cod_cli = _cod_cli;

    END IF;

    RETURN _msg || cliente.nome;

END;

$$ LANGUAGE plpgsql;

SELECT * FROM FN_EXEMPLO_PARAMETROS('c1')