USE [beraudent]
GO
/****** Object:  StoredProcedure [dbo].[sp_loguear]    Script Date: 17/11/2015 7:10:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[sp_loguear]
	@nickname varchar(30),
	@password varchar(40),
	@logueado int output
	/* @mensaje varchar(50) output */
as
begin
	select @logueado=COUNT(u.nickname) from usuario u where nickname=@nickname and password=@password	
end