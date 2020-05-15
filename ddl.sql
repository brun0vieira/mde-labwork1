drop table clientes cascade constraints;
drop table activos cascade constraints;
drop table dispositivos cascade constraints;
drop table eventos cascade constraints;
drop table alertas cascade constraints;
drop table faturas cascade constraints;

create table clientes (
    id_cliente integer not null,
    nome varchar(50),
    contacto varchar(50),
    idade integer
); 
alter table clientes add constraint id_cliente_pkey primary key (id_cliente);

create table activos (
    id_activo integer not null,
    tipologia varchar(50),
    tipo varchar(50),
    coordenadas varchar(50),
    localizacao varchar(50),
    vigilancia_inicio varchar(10), 
    vigilancia_fim varchar(10),
    id_cliente integer not null
);
alter table activos add constraint id_activo_pkey primary key (id_activo);

create table dispositivos (
    id_dispositivo integer not null,
    descricao varchar(50),
    id_activo integer not null,
    tarifa integer
);
alter table dispositivos add constraint id_dispositivo_pkey primary key (id_dispositivo);

create table eventos (
    id_evento integer not null,
    data_evento varchar(25),
    gravidade varchar(50),
    id_dispositivo integer not null
);

alter table eventos add constraint id_evento_pkey primary key (id_evento);

create table alertas (
    id_alerta integer not null,
    data_alerta varchar(25),
    gravidade varchar(50),
    id_dispositivo integer not null,
    id_evento integer not null references eventos(id_evento), constraint evento_alerta unique (id_evento)
);
alter table alertas add constraint id_alerta_pkey primary key (id_alerta);

create table faturas (
    id_fatura integer not null,
    valor integer,
    id_cliente integer not null
);
alter table faturas add constraint id_fatura_pkey primary key (id_fatura);

--relacoes
--clientes 1:N activos
alter table activos add constraint id_cliente_fkey foreign key (id_cliente) references clientes(id_cliente) on delete cascade;

--activos 1:N dispositivos
alter table dispositivos add constraint id_activo_fkey foreign key (id_activo) references activos(id_activo) on delete cascade;

--dispositivos 1:N eventos
alter table eventos add constraint id_dispositivo_fkey foreign key (id_dispositivo) references dispositivos(id_dispositivo) on delete cascade;

--eventos 1:1 alertas
-- already done while creating the table

--clientes 1:N faturas
-- the table 'faturas' can contain 12 rows for each client, i.e., in one year one client can have 12 invoices, one for each month.
alter table faturas add constraint id_cliente_faturas_fkey foreign key (id_cliente) references clientes(id_cliente) on delete cascade;


