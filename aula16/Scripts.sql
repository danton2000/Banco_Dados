create table alterada(
	cod serial primary key,
	valor varchar(50)
);

create table log(
	cod serial primary key,
	data date,
	autor varchar(20),
	alteracao varchar(6))
;

create function gera_log() returns trigger as
$$
Begin
insert into log (data, autor, alteracao) values (now(), user, TG_OP);
return new;
end;
$$ language 'plpgsql';

create trigger tr_gera_log after insert or update or delete on alterada for each row execute
procedure gera_log();

SELECT * FROM LOG;

SELECT * FROM ALTERADA;

INSERT INTO ALTERADA(
	VALOR
) VALUES (
	'TESTE DE INSERT2'
)

UPDATE ALTERADA
SET VALOR = 'ALTERAÇÃO NO VALOR'

BEGIN TRANSACTION
	
	DELETE FROM ALTERADA
	
ROLLBACK TRANSACTION

---

