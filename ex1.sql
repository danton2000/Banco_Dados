-- 1 – Selecionar o nome do cliente e quantidade de produtos comprados, somente para
--clientes que compraram Coca Cola


SELECT DISTINCT CLIE.CLIENTE, ITEN.QTDE, PROD.DESCRICAOPRODUTO
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF and ITEN.DTVENDA = VEND.DTVENDA
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE
WHERE PROD.DESCRICAOPRODUTO = 'Coca Cola';

--– 2 - Selecionar o nome do cliente e o valor total comprado por ele

SELECT CLIE.cliente, SUM(VEND.vlvenda)
FROM XCLIENTE CLIE
INNER JOIN XVENDA VEND ON VEND.codcliente = CLIE.codcliente
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF and ITEN.DTVENDA = VEND.DTVENDA AND ITEN.CODPRODUTO IN 
(SELECT PROD.CODPRODUTO FROM XPRODUTO PROD)
--INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
--INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE
GROUP BY CLIE.cliente

--– 3 - Selecionar a descrição e o maior preço de produto vendido.

SELECT PROD.DESCRICAOPRODUTO, MAX(PROD.PRECO)
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE
GROUP BY PROD.DESCRICAOPRODUTO;

--– 4 - Selecionar o nome do cliente e descrição do tipo de pagamento utilizado nas vendas.

SELECT DISTINCT CLIE.CLIENTE, TIPO.DESCRICAOTPPAGAMENTO
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF
INNER JOIN XTIPOSPAGAMENTO TIPO ON TIPO.CODTPPAGAMENTO = VEND.CODTPPAGAMENTO
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE;

--– 5 - Selecionar o nome do cliente, nnf, data da venda, descrição do tipo de pagamento, 
-- descrição do produto e quantidade vendida dos itens vendidos. 

SELECT CLIE.CLIENTE, VEND.NNF, VEND.DTVENDA, TIPO.DESCRICAOTPPAGAMENTO, PROD.DESCRICAOPRODUTO, ITEN.QTDE
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF
INNER JOIN XTIPOSPAGAMENTO TIPO ON TIPO.CODTPPAGAMENTO = VEND.CODTPPAGAMENTO
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE;

--– 6 - Selecionar a média de preço dos produtos vendidos

SELECT 
CAST(AVG(PROD.PRECO)AS DECIMAL(10,3)) DECIMAL_FORMAT
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF
INNER JOIN XTIPOSPAGAMENTO TIPO ON TIPO.CODTPPAGAMENTO = VEND.CODTPPAGAMENTO
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE;

--– 7 - Selecionar o nome do cliente e a descrição dos produtos comprados por ele. Não repetir
-- os dados (distinct)


SELECT 
DISTINCT CLIE.CLIENTE, PROD.DESCRICAOPRODUTO
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF
INNER JOIN XTIPOSPAGAMENTO TIPO ON TIPO.CODTPPAGAMENTO = VEND.CODTPPAGAMENTO
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE
ORDER BY CLIE.CLIENTE;

--– 8 - Selecionar a descrição do tipo de pagamento, e a maior data de venda que utilizou esse
-- tipo de pagamento. Ordenar a consulta pela descrição do tipo de pagamento.


SELECT 
TIPO.DESCRICAOTPPAGAMENTO, MAX(VEND.DTVENDA)
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF
INNER JOIN XTIPOSPAGAMENTO TIPO ON TIPO.CODTPPAGAMENTO = VEND.CODTPPAGAMENTO
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE
GROUP BY TIPO.DESCRICAOTPPAGAMENTO
ORDER BY TIPO.DESCRICAOTPPAGAMENTO;

--– 9 - Selecionar a data da venda e a média da quantidade de produtos vendidos. Ordenar pela
-- data da venda decrescente.

SELECT 
VEND.DTVENDA, AVG(ITEN.QTDE)
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF
INNER JOIN XTIPOSPAGAMENTO TIPO ON TIPO.CODTPPAGAMENTO = VEND.CODTPPAGAMENTO
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE
GROUP BY VEND.DTVENDA
ORDER BY VEND.DTVENDA DESC;

--– 10 – Selecionar a descrição do produto e a média de quantidades vendidas do produto.
-- Somente se a média for superior a 4

SELECT 
PROD.DESCRICAOPRODUTO, AVG(ITEN.QTDE)
FROM XVENDA VEND
INNER JOIN XITENSVENDA ITEN ON ITEN.NNF = VEND.NNF
INNER JOIN XTIPOSPAGAMENTO TIPO ON TIPO.CODTPPAGAMENTO = VEND.CODTPPAGAMENTO
INNER JOIN XPRODUTO PROD ON PROD.CODPRODUTO = ITEN.CODPRODUTO
INNER JOIN XCLIENTE CLIE ON CLIE.CODCLIENTE = VEND.CODCLIENTE
GROUP BY PROD.DESCRICAOPRODUTO
HAVING AVG(ITEN.QTDE) > 4
ORDER BY PROD.DESCRICAOPRODUTO DESC;