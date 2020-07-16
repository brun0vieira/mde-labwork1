-- Clientes
-- Create
insert into clientes(id_cliente, nome, contacto, idade) values(sequence_clientes.nextval, 'bruno vieira', 'bar.vieira@campus.fct.unl.pt', 22);
insert into clientes(id_cliente, nome, contacto, idade) values(sequence_clientes.nextval, 'serafim ciobanu', 's.ciobanu@campus.fct.unl.pt', 23);
insert into clientes(id_cliente, nome, contacto, idade) values(sequence_clientes.nextval, 'andre rebelo', 'a.rebelo@gmail.com', 30);
insert into clientes(id_cliente, nome, contacto, idade) values(sequence_clientes.nextval, 'jorge jesus', 'j.jesus@gmail.com', 17);
insert into clientes(id_cliente, nome, contacto, idade) values(sequence_clientes.nextval, 'pedro mendonca', 'p.mendonca@outlook.pt', 14);
-- Read adult clients
select nome, contacto from clientes where idade >= 18;
-- Update Jorge Jesus age. He's 66y old.
update clientes set idade=66 where nome = 'jorge jesus';
-- Delete underage clients
delete from clientes where idade < 18;
-- Visualize our table clientes
select * from clientes;

-- Activos
-- Create
-- Activos estaticos
insert into activos(id_activo, tipologia, tipo, localizacao, vigilancia_inicio, vigilancia_fim, id_cliente) 
    values(sequence_activos.nextval, 'cafe', 'estatico', 'lisboa', '08:30:00', '18:00:00', 1);
insert into activos(id_activo, tipologia, tipo, localizacao, vigilancia_inicio, vigilancia_fim, id_cliente)
    values(sequence_activos.nextval, 'restaurante', 'estatico', 'algarve', '12:00:00', '23:00:00', 2);
insert into activos(id_activo, tipologia, tipo, localizacao, vigilancia_inicio, vigilancia_fim, id_cliente)
    values(sequence_activos.nextval, 'fabrica', 'estatico', 'linda-a-velha', '06:00:00', '23:00:00', 3);
insert into activos(id_activo, tipologia, tipo, localizacao, vigilancia_inicio, vigilancia_fim, id_cliente)
    values(sequence_activos.nextval, 'armazem', 'estatico', 'algarve', '20:00:00', '23:59:59', 4);
-- Activos moveis
insert into activos(id_activo, tipologia, tipo, coordenadas, vigilancia_inicio, vigilancia_fim, id_cliente)
    values(sequence_activos.nextval, 'drone', 'movel', 'N 38° 45 40" , W 9° 09 38"', '20:00:00', '23:00:00', 1);
insert into activos(id_activo, tipologia, tipo, coordenadas, vigilancia_inicio, vigilancia_fim, id_cliente)
    values(sequence_activos.nextval, 'carro', 'movel', 'N 20° 37 11" , W 40° 11 40"', '14:30:00', '16:00:00', 2);
insert into activos(id_activo, tipologia, tipo, coordenadas, vigilancia_inicio, vigilancia_fim, id_cliente)
    values(sequence_activos.nextval, 'computador', 'movel', 'N 22° 39 40" , W 12° 09 46"', '00:00:00', '23:59:59', 3);
insert into activos(id_activo, tipologia, tipo, coordenadas, vigilancia_inicio, vigilancia_fim, id_cliente)
    values(sequence_activos.nextval, 'telemovel', 'movel', 'N 31° 28 39" , W 8° 22 24"', '00:00:00', '23:59:59', 4);
-- Read static
select tipologia from activos where tipo='estatico';
-- Update 
update activos set vigilancia_fim = '23:00:00' where tipologia ='computador';
-- Delete 
delete from activos where coordenadas = 'N 31° 28 39" , W 8° 22 24"';
-- Visualize our table activos
select * from activos;

-- Dispositivos
-- Create
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'gps tracker', 6);
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'camera', 1);
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'detetor movimentos', 3);
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'camera', 2);
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'sensores', 7);
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'camera', 3);
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'camera', 4);
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'detetor movimentos', 4);
insert into dispositivos(id_dispositivo, descricao, id_activo) 
    values(sequence_dispositivos.nextval, 'camera', 6);
-- How many cameras
select count(*) from dispositivos where descricao='camera'; 
-- Visualize tabke dispositivos
select * from dispositivos;

-- Eventos
-- Create
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2020/01/01 14:57:00', 'grave', 1);
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2019/12/30 09:47:00', 'muito grave', 2);
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2018/03/22 22:31:00', 'medio', 3);
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2017/04/19 13:12:00', 'grave', 4);
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2020/02/19 22:01:00', 'ligeiro', 5);
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2020/03/11 09:39:00', 'grave', 6);
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2019/02/19 21:12:00', 'medio', 7);
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2020/04/01 23:58:00 ', 'muito grave', 8);
insert into eventos(id_evento, data_evento, gravidade, id_dispositivo)
    values(sequence_eventos.nextval, '2020/04/02 15:27:00', 'grave', 9);
-- Read
select * from eventos where gravidade ='grave' or gravidade ='muito grave';
-- Update
update eventos set gravidade = 'medio' where id_dispositivo =9;
-- Visualize table eventos
select * from eventos;
