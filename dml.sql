drop sequence sequence_clientes;
drop sequence sequence_activos;
drop sequence sequence_dispositivos;
drop sequence sequence_eventos;
drop sequence sequence_alertas;
drop sequence sequence_faturas;

--auto_increment is not avaliable so we need to create a sequence for each table identifier.
create sequence sequence_clientes start with 1 increment by 1 nocycle;
create sequence sequence_activos start with 1 increment by 1 nocycle;
create sequence sequence_dispositivos start with 1 increment by 1 nocycle;
create sequence sequence_eventos start with 1 increment by 1 nocycle;
create sequence sequence_alertas start with 1 increment by 1 nocycle;
create sequence sequence_faturas start with 1 increment by 1 nocycle;


-- rf3
create type alertas_type as object (
    id_alerta integer,
    data_alerta varchar(25),
    gravidade varchar(50)
);

create or replace type alertas_table_type as table of alertas_type;

create or replace function alertas_numa_data(activo_pretendido varchar, data_1 varchar, data_2 varchar)
return alertas_table_type 
pipelined
as
begin
    
    for rec in (select * from alertas_activo
                where tipologia = activo_pretendido and
                to_date(data_alerta, 'YYYY/MM/DD HH24:MI:SS') between to_date(data_1, 'YYYY/MM/DD HH24:MI:SS') and to_date(data_2, 'YYYY/MM/DD HH24:MI:SS')
    )
    loop
        pipe row (alertas_type(rec.id_alerta, rec.data_alerta, rec.gravidade));
    end loop;
    return;
end;

-- rf5
-- first we create an object that represents one row of the results
create or replace type dispositivo_type as object (
    id_dispositivo integer,
    descricao varchar(50),
    id_activo integer
);
-- then we create a collection (table type) of the object type created before
create or replace type dispositivo_table_type as table of dispositivo_type;

-- afterwards we create a function that returns the table type 
create or replace function dispositivo_pipelined(activo integer) return dispositivo_table_type
pipelined
as
begin
    
    for rec in (select * from dispositivos_activos where id_activo = activo)
    loop 
        pipe row (dispositivo_type(rec.id_dispositivo, rec.descricao, rec.id_activo));
    end loop;
    return;
end;

-- Requisito 12 - Procedure para mudar o contacto de um cliente
create or replace procedure mudar_contacto(nome_cliente_pretendido IN clientes.nome%type, contacto_pretendido IN clientes.contacto%type)
is

begin

    update clientes c
    set c.contacto = contacto_pretendido
    where c.nome = nome_cliente_pretendido;
    commit;
    
end mudar_contacto;

-- Requisito 9 - Visualizar os activos associado ao seu cliente
drop view clientes_activos;
create view clientes_activos as
    select c.id_cliente, c.nome, ac.id_activo, ac.tipologia, ac.tipo
    from clientes c
    inner join activos ac
        on ac.id_cliente = c.id_cliente;

select * from clientes_activos;