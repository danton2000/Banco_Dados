-- a resposta
SELECT
	NOME
FROM
	ALUNO
WHERE
NOT EXISTS (
	--Todo
	SELECT ID 
	FROM DISCIPLINA
	WHERE ID LIKE '%BD%'
	
	EXCEPT
	-- O que foi 'realizado'
	SELECT IDALUNO, IDDISCIPLINA
	FROM ALUNOTURMA
	WHERE
	ALUNO.ID = ALUNOTURMA.ID
)