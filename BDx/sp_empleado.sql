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
if(@codigo='a')
	insert into empleado (codigo,apellidos,nombres,rut,[id_area-e]) values (@codigo,@apellidos,@nombres,@id_area)
else
	if(@codigo=1)
	update empleado set codigo=@codigo,apellidos=@apellidos,nombres=@nombres,rut=@rut,[id_area-e]=@id_area where codigo=@codigo
end

go
/*PROCEDIMIENTO PARA SELECCIONAR UNA TABLA*/
create procedure sp_empleado_seleccionar_tabla
as
begin
	select * from empleado
end
go
/*PROCEDMIENTO PARA SELECCIONAR UN REGISTRO POR codigo*/
create procedure sp_empleado_seleccionar_registro( @valor varchar(10) )
as
begin
	select * from empleado where codigo=@valor
end
go
/*PROCEDIMIENTO PARA ELIMINAR REGISTRO*/
create procedure sp_empleado_eliminar( @valor varchar(10) )
as
begin
	delete from empleado where codigo=@valor
end
go
/*PROCEDIMIENTO PARA SELECCIONAR FILTRO*/
create procedure sp_empleado_filtrar_apellido( @valor varchar (20))
as
begin
	select * from empleado where apellidos like @valor + '%'
end
go
/*PROCEDIMIENTO PARA BUSCAR POR codigo*/
create procedure sp_empleado_buscar_codigo( @valor varchar(10), @encontrado tinyint output )
as
begin
	select @encontrado =count(*) from empleado where codigo=@valor	
end
go
/*PROCEDIMIENTO PARA BUSCAR POR NOMBRE*/
create procedure sp_empleado_buscar_apellido( @valor varchar(45), @encontrado tinyint output )
as
begin
	select @encontrado =count(*) from empleado where apellidos=@valor	
end