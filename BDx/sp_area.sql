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

/*PRODEDIMIENTO PARA INSERTAR Y ACTUALIZAR*/
create procedure sp_area_ia (
	@operacion varchar(1),
	@id tinyint,
	@nombre varchar(45)	
)
as
begin
if(@operacion='I')
	insert into area values (DEFAULT,@nombre)
else
	if(@operacion='A')
		update area set nombre=@nombre where id=@id
end

