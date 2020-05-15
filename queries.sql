/* 
 * Requisito 2
 */ 
insert into alertas(id_alerta, data_alerta, gravidade, id_dispositivo, id_evento)
select sequence_alertas.nextval, data_evento, gravidade, id_dispositivo, id_evento
from eventos
where gravidade = 'medio' or gravidade ='grave' or gravidade='muito grave';

-- Visualize the table alertas. The clients should be notified.
select * from alertas;

/* 
 * Requisito 3
 */

drop table alertas_activo;
create table alertas_activo (
    id_alerta integer not null,
    data_alerta varchar(25),
    gravidade varchar(50),
    tipologia varchar(50)
);

insert into alertas_activo(id_alerta, data_alerta, gravidade, tipologia) 
    select al.id_alerta, al.data_alerta, al.gravidade, ac.tipologia
    from alertas al, activos ac, dispositivos d
    where al.id_dispositivo = d.id_dispositivo and
          d.id_activo = ac.id_activo;

select * from alertas_activo;          
-- Inserir a data mais antiga primeiro que a data mais recente. 
select id_alerta, data_alerta, gravidade from table(alertas_numa_data('carro', '2019/12/01 00:00:00', '2020/03/03 00:00:00'));

/* 
 * Requisito 4
 */
 
select localizacao, count(*) from activos group by localizacao;

/* 
 * Requisito 5
 */
 
-- we need to have a table that connects the tables: dispositivos and activos
drop table dispositivos_activos;              
create table dispositivos_activos (
    id_dispositivo integer not null,
    descricao varchar(50),
    id_activo integer not null
);

-- we populate our new table
insert into dispositivos_activos(id_dispositivo, descricao, id_activo)
    select d.id_dispositivo, d.descricao, d.id_activo
    from dispositivos d, activos a
    where d.id_activo = a.id_activo;
 
select * from activos;
-- now we just need to choose the id_activo we want.
select id_dispositivo, descricao, id_activo from table(dispositivo_pipelined(6));

/* 
 * Requisito 6
 */

select al.data_alerta, al.gravidade, ac.id_activo, ac.tipologia, ac.tipo, ac.id_cliente
from activos ac, dispositivos di, alertas al
where (ac.id_activo = di.id_activo) and (di.id_dispositivo = al.id_dispositivo) and
      (to_date(al.data_alerta, 'YYYY/MM/DD HH24:MI:SS') between (sysdate-180) and sysdate);
      
/* 
 * Requisito 7
 */

select c.id_cliente, c.nome, c.contacto, al.id_alerta, al.data_alerta, al.gravidade, al.id_dispositivo
from clientes c, activos a, dispositivos d, alertas al
where (c.id_cliente = a.id_cliente) and (a.id_activo = d.id_activo) and
      (d.id_dispositivo = al.id_dispositivo);
      

/* 
 * Requisito 10 - Mostrar os dispositivos que é necessário ter mais stock devido à maior utilização destes.
 *                APesar de termos uma funcao de agregacao count, achamos que é uma query simples relevante.
 */
 
select count(*) quantidade, descricao from dispositivos
group by descricao;

/* 
 * Requisito 11 - Media da idade dos clientes de forma a que a relação cliente-secureALL seja adequada a faixa etaria dos clientes
 */

select avg(idade) media_idades from clientes;

/* 
 * Requisito 12 - Procedure para mudar o contacto de um cliente
 */

call mudar_contacto('bruno vieira', 'brunoarvieira@gmail.com');
select * from clientes;
