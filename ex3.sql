-- 1) – Criar uma view com o nome de cursosanalista, que contém o nome do curso, nome do
-- analista e salário do analista com um aumento de 10%.
CREATE OR REPLACE VIEW cursosanalista AS
SELECT CUR.CURSO, 
ANA.ANALISTA, 
CAST(ANA.SALARIO * 1.10 AS NUMERIC(15,2)) AS "salario_aumentado"
FROM ANALISTA ANA
INNER JOIN CURSO CUR ON CUR.CODCURSO = ANA.CODCURSO;

-- 2) Montar uma consulta que mostra o nome do programador e a quantidade de dias de
-- férias. Caso o programador tenha idade:
-- de 20 a 24 anos 18 dias
-- de 25 a 35 anos 21 dias
-- acima de 35 anos 25 dias

SELECT 
PRO.PROGRANADOR,
PRO.IDADE,
CASE
	WHEN PRO.IDADE >= 20 AND PRO.IDADE <= 24 THEN 18
	WHEN PRO.IDADE >= 25 AND PRO.IDADE <= 35 THEN 21
	ELSE 25
END AS dias_ferias
FROM PROGRAMADOR PRO;

-- 3) – Criar uma view com o nome de ativanalista, contendo o nome do analista e a
-- quantidade de atividades de análise que ele realizou.
CREATE OR REPLACE VIEW ativanalista AS
SELECT
ANA.ANALISTA,
COUNT(ATI.DESCRICAO) AS "quantidade_atividades"
FROM ANALISTA ANA
INNER JOIN ATIVIDADESANALISE ATI ON ATI.CODANALISTA = ANA.CODANALISTA
GROUP BY ANA.ANALISTA;

