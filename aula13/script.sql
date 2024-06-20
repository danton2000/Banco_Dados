CREATE or REPLACE FUNCTION listaClientes() RETURNS integer AS $$
DECLARE
    _clientes RECORD;
BEGIN
    raise notice 'Listando Clientes...';
    --1 linha de cada vez,
    FOR _clientes IN SELECT * FROM cliente ORDER BY nome LOOP
    raise notice 'Cliente: % ', _clientes.nome;
    --movendo o cursor no end loop para pegar o proximo valor
    END LOOP;
    raise notice 'Lista Concluída.';
RETURN 1;
END;
$$ LANGUAGE plpgsql;