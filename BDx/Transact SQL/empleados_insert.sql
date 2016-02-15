use beraudent

select * from empleado

select * from area

insert into empleado (codigo,apellidos,nombres, rut, [id_area-e]) values
('CONTA0001','ABEL RAFAEL','OBANDO FLORIAN','24215707-9',1),
('CONTA0002','HECTOR JOEL','ALVA FLORIAN','24215507-9',1),
('CONTA0003','CLADIA ESTEFANY','VIRU','24415707-9',1),
('RECEP0001','NATALY','PASTEN TELO','24335707-9',1)

update empleado set [id_area-e]=2 where codigo='RECEP0001';