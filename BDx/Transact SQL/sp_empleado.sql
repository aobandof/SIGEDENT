use beraudent
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
if(@codigo='i')
	insert into empleado (codigo,apellidos,nombres,rut,[id_area-e]) values (@codigo,@apellidos,@nombres,@rut,@id_area)
else
	update empleado set codigo=@codigo,apellidos=@apellidos,nombres=@nombres,rut=@rut,[id_area-e]=@id_area where codigo=@codigo
end

go
/*PROCEDIMIENTO PARA SELECCIONAR UNA TABLA*/
create procedure sp_empleado_seleccionar_tabla
as
begin
	select codigo,apellidos,nombres,rut,nombre as nombre_area from empleado, area where [id_area-e]=id
end
go
/*PROCEDMIENTO PARA SELECCIONAR UN REGISTRO POR codigo*/
create procedure sp_empleado_seleccionar_codigo( @codigo varchar(10) )
as
begin
	select codigo,apellidos,nombres,rut,nombre as nombre_area from empleado, area where [id_area-e]=id and codigo=@codigo
end
go
/*PROCEDIMIENTO PARA ELIMINAR REGISTRO*/
create procedure sp_empleado_eliminar( @codigo varchar(10) )
as
begin
	delete from empleado where codigo=@codigo
end
go
/*PROCEDIMIENTO PARA SELECCIONAR FILTRO*/
create procedure sp_empleado_filtrar_apellidos( @apellidos varchar (20))
as
begin
	select codigo,apellidos,nombres,rut,nombre as nombre_area from empleado, area where [id_area-e]=id and apellidos like @apellidos + '%'
end
go
/*PROCEDIMIENTO PARA BUSCAR POR codigo*/
create procedure sp_empleado_buscar_codigo( @codigo varchar(10), @encontrado tinyint output )
as
begin
	select @encontrado =count(*) from empleado where codigo=@codigo	
end
go
/*PROCEDIMIENTO PARA BUSCAR POR APELLIDOS*/
create procedure sp_empleado_buscar_apellidos( @apellidos varchar(45), @encontrado tinyint output )
as
begin
	select @encontrado =count(*) from empleado where apellidos=@apellidos	
end