-- NOME DO CLIENTE, NUMERO DO PEDIDO, NOME DO PRODUTO
SELECT CLI.NOME NOME_CLIENTE, PED.NRO_PED NUM_PEDIDO, PRO.NOME NOME_PRODUTO
FROM CLIENTE CLI
INNER JOIN PEDIDO PED ON PED.COD_CLI = CLI.COD_CLI
INNER JOIN MOVIMENTO MOV ON MOV.NRO_PED = PED.NRO_PED
INNER JOIN PRODUTO PRO ON PRO.COD_PROD = MOV.COD_PROD
WHERE CLI.NOME = 'Super Merco';