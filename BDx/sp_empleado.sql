use beraudent
go

/*PROCEDIMIENTO PARA SELECCIONAR Y ELIMINAR*/
create procedure sp_empleado_se (
	@operacion varchar(1),
	@codigo varchar(10)
)
as
begin
if(@operacion='S')
	select * from empleado where codigo=@codigo
else 
	begin
	if(@operacion='E')
		delete from empleado where codigo=@codigo
	else
		select * from empleado
	end
end

go

/*PROCEDIMIENTO PARA INSERTAR Y ACTUALIZAR */
create procedure sp_empleado_grabar(
	@codigo varchar(10),
	@nombres varchar(45),
	@apellidos varchar(45),
	@rut varchar(10),
	@id_area tinyint
)
as
begin

if(@codigo=0)
	insert into empleado (codigo,nombres,apellidos,rut,id_area-e) values (@codigo,@nombres,@apellidos,@rut,@id_area)
else
	update empleado set nombres=@nombres where codigo=@codigo
end


/*YA NO SE USA, EN SU LUGAR sp_area_grabar */
/*PRODEDIMIENTO PARA INSERTAR Y ACTUALIZAR*/
CREATE procedure sp_area_ia (
	@operacion varchar(1),
	@codigo tinyint,
	@nombre varchar(45)	
)
as
begin
if(@operacion='I')
	insert into area (nombre) values (@nombre)
else
	if(@operacion='A')
		update area set nombre=@nombre where codigo=@codigo
end

go

/*PROCEDIMIENTO ALMACENADO PARA SELECCIONAR FILTRO*/
create procedure sp_area_filtrar(
	@filtro varchar (20)
)
as
begin
	select * from area where nombre like @filtro + '%'
end

