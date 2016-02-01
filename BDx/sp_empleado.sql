use beraudent
go

/*PROCEDIMIENTO PARA SELECCIONAR Y ELIMINAR*/
create procedure sp_area_se (
	@operacion varchar(1),
	@id tinyint
)
as
begin
if(@operacion='S')
	select * from area where id=@id
else 
	begin
		if(@operacion='E')
			delete from area where id=@id
		else
			select * from area
	end
end

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
	update area set nombre=@nombre where id=@id
end


/*YA NO SE USA, EN SU LUGAR sp_area_grabar */
/*PRODEDIMIENTO PARA INSERTAR Y ACTUALIZAR*/
CREATE procedure sp_area_ia (
	@operacion varchar(1),
	@id tinyint,
	@nombre varchar(45)	
)
as
begin
if(@operacion='I')
	insert into area (nombre) values (@nombre)
else
	if(@operacion='A')
		update area set nombre=@nombre where id=@id
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

