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

/*PRODEDIMIENTO PARA INSERTAR Y ACTUALIZAR*/
create procedure sp_empleado_ia (
	@operacion varchar(1),
	@codigo varchar(15),
	@apellidos varchar(45),
	@nombres varchar(45),
	@rut varchar(10)

)
/* FALTA PARA EL ID DEL AREA */
as
begin
if(@operacion='I')
	insert into empleado values (@codigo,@apellidos,@nombres,@rut)
else
	if(@operacion='A')
		update empleado set codigo=@codigo, apellidos=@apellidos, nombres=@nombres, rut=@rut
end

