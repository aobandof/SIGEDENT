use beraudent
go
/*PROCEDIMIENTO PARA INSERTAR Y ACTUALIZAR */
alter procedure sp_area_grabar(
	@id tinyint,
	@nombre varchar(45)
)
as
begin
if(@id=0)
	insert into area (nombre) values (@nombre)
else
	update area set nombre=@nombre where id=@id
end

go
/*PROCEDIMIENTO PARA SELECCIONAR UNA TABLA*/
alter procedure sp_area_seleccionar_tabla
as
begin
	select * from area
end
go
/*PROCEDMIENTO PARA SELECCIONAR UN REGISTRO POR ID*/
alter procedure sp_area_seleccionar_id( @id tinyint )
as
begin
	select * from area where id=@id
end
go
/*PROCEDIMIENTO PARA ELIMINAR REGISTRO*/
alter procedure sp_area_eliminar( @valor tinyint )
as
begin
	delete from area where id=@valor
end
go
/*PROCEDIMIENTO PARA SELECCIONAR FILTRO*/
alter procedure sp_area_filtrar_nombre( @nombre varchar (20))
as
begin
	select * from area where nombre like @nombre + '%'
end
go
/*PROCEDIMIENTO PARA BUSCAR POR ID*/
alter procedure sp_area_buscar_id( @id tinyint, @encontrado tinyint output )
as
begin
	select @encontrado =count(*) from area where id=@id	
end
go
/*PROCEDIMIENTO PARA BUSCAR POR NOMBRE*/
alter procedure sp_area_buscar_nombre( @nombre varchar(45), @encontrado tinyint output )
as
begin
	select @encontrado =count(*) from area where nombre=@nombre	
end