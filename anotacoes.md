# Anotações

## Algebra Relacional

## Seleção

Sigma(Seleção)

Sigma coluna_tabela > 5 (nome_tabela) = Select * from nome_tabela where coluna_tabela >4 5

nome_tabela = Força bruta(Selet * from nome_tabela)

Sigma(consulta)(sigma (consulta) (tabela)) = executa primeiro o que está em ()

R1 = subquery, resultado, visão

Sigma nome_coluna >5 (R1)

## Projeção
PI(Projeção) mostrar campos de uma consulta

PI nome_coluna, nome_coluna(nome_tabela) = SELECT NOME_COLUNA, NOME_COLUNA FROM NOME_TABELA

## Seleção e Projeção
PI nome_coluna, nome_coluna2 (SIGMA nome_coluna > 5 (nome_tabela))
-- Seleciona depois projeta

## Produto Cartesiano
nome_tabela X nome_tabela

## JOIN
SIGMA nome_coluna = nome_coluna (nome_tabela X nome_tabela)