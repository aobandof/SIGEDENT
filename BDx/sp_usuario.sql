use beraudent

go

/*PROCEDIMIENTO PARA LOGUEAR*/
create procedure sp_usuario_loguear (
	@nick varchar(15),
	@password varchar(20)
)
as
begin
	select * from usuario where nick=@nick and password=@password
end

go

/*PROCEDIMIENTO PARA SELECCIONAR Y ELIMINAR*/
create procedure sp_usuario_se (
	@operacion varchar(1),
	@nick varchar(15)
)
as
begin
if(@operacion='S')
	select * from usuario where nick=@nick
else 
	begin
		if(@operacion='E')
			delete from usuario where nick=@nick
		else
			select * from usuario
	end
end

go

/*PRODEDIMIENTO PARA INSERTAR Y ACTUALIZAR*/
create procedure sp_usuario_ia (
	@operacion varchar(1),
	@nick varchar(15),
	@password varchar(20),
	@apellidos varchar(45),
	@nombres varchar(45),
	@permisos varchar(1)
)
as
begin
if(@operacion='I')
	insert into usuario values (@nick,@password,@apellidos,@nombres,@permisos)
else
	if(@operacion='A')
		update usuario set nick=@nick, password=@password, apellidos=@apellidos, nombres=@nombres, permisos=@permisos
end


select * from usuario where nick='cpilar'