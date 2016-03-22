use beraudent

go

/*PROCEDIMIENTO PARA LOGUEAR*/
create procedure sp_usuario_loguear (
	@user varchar(10),
	@password varchar(20)
)
as
begin
	select * from usuario where user=@user and password=@password
end

go
