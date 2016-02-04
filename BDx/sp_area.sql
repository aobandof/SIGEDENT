use beraudent
go
/*PROCEDIMIENTO PARA INSERTAR Y ACTUALIZAR */
create procedure sp_area_grabar(
	@id tinyint,
	@nombre varchar(45)
)
as
begin
if(@id=0)
	insert into area (nombre) values (@nombre)
else
	if(@id=1)
	update area set nombre=@nombre where id=@id
end

go
/*PROCEDIMIENTO PARA SELECCIONAR UNA TABLA*/
create procedure sp_area_seleccionar_tabla
as
begin
	select * from area
end
go
/*PROCEDMIENTO PARA SELECCIONAR UN REGISTRO POR ID*/
create procedure sp_area_seleccionar_registro( @valor tinyint )
as
begin
	select * from area where id=@valor
end
go
/*PROCEDIMIENTO PARA ELIMINAR REGISTRO*/
create procedure sp_area_eliminar( @valor tinyint )
as
begin
	delete from area where id=@valor
end
go
/*PROCEDIMIENTO PARA SELECCIONAR FILTRO*/
create procedure sp_area_filtrar_nombre( @valor varchar (20))
as
begin
	select * from area where nombre like @valor + '%'
end
go
/*PROCEDIMIENTO PARA BUSCAR POR ID*/
create procedure sp_area_buscar_id( @valor tinyint, @encontrado tinyint output )
as
begin
	select @encontrado =count(*) from area where id=@valor	
end
go
/*PROCEDIMIENTO PARA BUSCAR POR NOMBRE*/
create procedure sp_area_buscar_nombre( @valor varchar(45), @encontrado tinyint output )
as
begin
	select @encontrado =count(*) from area where nombre=@valor	
end