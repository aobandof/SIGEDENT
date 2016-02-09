use beraudent

create procedure sp_usuario_loguear_antiguo(
	@nickname varchar(15),
	@password varchar(20),
	@mensaje varchar(200) output
)
as
begin try
	select @mensaje=nickname from usuario where @nickname=nickname and @password=password
	if (@mensaje!='') begin
		select * from usuario where @nickname=nickname and @password=password
		select @mensaje=''
	end
	else
		select @mensaje='datos incorrectos para iniciar sesion'
end try
begin catch
	select @mensaje='Se presentó el siguinte error: ' + ERROR_MESSAGE()
end catch