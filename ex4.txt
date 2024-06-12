# Tarefas
    Esquema do sistema acadêmico.
    > DEPTO (CodDepto(PK), NomeDepto)

    > DISCIPLINA (CodDepto(PK_COMPOSTA), NumDisc(PK_COMPOSTA), NomeDisc, CreditosDisc)

    > PREREQ (CodDepto(PK_COMPOSTA), NumDisc(PK_COMPOSTA), CodDeptoPreReq(PK_COMPOSTA), NumDiscPreReq(PK_COMPOSTA))

    > TURMA (AnoSem(PK_COMPOSTA), CodDepto(PK_COMPOSTA), NumDisc(PK_COMPOSTA), SiglaTur(PK_COMPOSTA), CapacTur)

    > HORARIO (AnoSem(PK_COMPOSTA), CodDepto(PK_COMPOSTA), NumDisc(PK_COMPOSTA), SiglaTur(PK_COMPOSTA), DiaSem(PK_COMPOSTA), HoraInicio(PK_COMPOSTA), NumHoras, CodPred, NumSala)

    > PREDIO (CodPred(PK), NomePred)

    > SALA (CodPred(PK_COMPOSTA), NumSala(PK_COMPOSTA), CapacSala)

    > PROFESSOR (CodProf(PK_COMPOSTA), NomeProf(PK_COMPOSTA), CodTit(PK_COMPOSTA), CodDepto(PK_COMPOSTA))

    > PROFTURMA (AnoSem(PK_COMPOSTA), CodDepto(PK_COMPOSTA), NumDisc(PK_COMPOSTA), SiglaTur(PK_COMPOSTA), CodProf(PK_COMPOSTA))
    
    > TITULAÇÃO (CodTit(PK), NomeTit)
## Observações
    • NumDisc identifica a disciplina dentro de um departamento;
    • Uma disciplina pode ter várias disciplinas como pré-requisito e um pré-requisito
    pode ser usado para várias disciplinas.
    • NumSala identifica a sala dentro de um prédio.
    • SiglaTur identifica uma turma de uma disciplina dentro de uma ano/semestre.
    • Uma turma pode ter vários professores e um professor pode ser professor de
    várias turmas.
    • Os campos sublinhados fazem parte da Pk.

### Monte a consulta, usando a notação da Álgebra Relacional.
    1. Obter os códigos dos diferentes departamentos que tem turmas no ano-semestre
    2002/1
    Resposta:  
    πCodDepto (σAnoSem = '2002/1') (TURMA)

    2. Obter os códigos dos professores que são do departamento de código 'INF01' e
    que ministraram uma turma em 2002/1.
    Resposta:

    πCodProf (σCodDepto = 'INF01' and AnoSem = '2002/1') (PROFTURMA)
    
    Resposta 2(Talvez):
    σPROFESSOR.CodProf(
        σPROFESSOR.CodDepto = 'INF01' and TURMA.AnoSem = '2002/1'(
            σPROFESSOR.CodDepto = TURMA.CodDepto (
                PROFESSOR x TURMA
            )
        )
    )


    3. Obter os códigos dos professores com título 'Doutor' que não ministraram aulas
    em 2002/1.
    Resposta:

    πPROFESSOR.CodProf(
        TITULAÇÃO.NomeTit = 'Doutor'(
            σPROFESSOR.CodTit = TITULAÇÃO.CodTit (
                PROFESSOR x TITULAÇÃO
            )
        )
    )

    ∩

    πPROFESSOR.CodProf(
        σTURMA.AnoSem <> '2002/1'(
            σPROFESSOR.CodDepto = TURMA.CodDepto (
                PROFESSOR x TURMA
            )
        )
    )

    4. Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na
    sala 101 do prédio denominado 'Informática - Salas de Aula'.
    Resposta:

    π DEPTO.NomeDepto(
        (σ HORARIO.AnoSem = '2002/1' and HORARIO.NumSala = '101' and  PREDIO.NomePred = 'Informática - Salas de Aula'
            (σ DEPTO.CodDepto = HORARIO.CodDepto and HORARIO.CodPred = PREDIO.CodPred
                (
                    DEPTO 
                    X 
                    HORARIO
                    x
                    PREDIO
                )
            )
        )
    )

    5. Obter o dia da semana, a hora de início e o número de horas de cada horário de
    cada turma ministrada por um professor de nome `Antonio Santos', em 2002/1, na
    sala 101 do prédio 25.
    Resposta:

    π HORARIO.DiaSem, HORARIO.HoraInicio, HORARIO.NumHoras (
        (σ PROFESSOR.NomeProf = 'Antonio Santos' and HORARIO.AnoSem = '2002/1' and HORARIO.NumSala = '101' and PREDIO.CodPred = 25
            (σ PROFESSOR.CodDepto = HORARIO.CodDepto and HORARIO.CodPred = PREDIO.CodPred
                (
                    PROFESSOR
                    X
                    HORARIO
                    x
                    PREDIO
                )
            )
        )
    )