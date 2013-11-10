CREATE FUNCTION cantTorneosActivos()
returns int
BEGIN
	declare @i int
	select @i = COUNT(*) from torneo 
	where ((TORN_FECHA_INICIO > GETDATE()) and (TORN_FECHA_FIN < GETDATE()))
	return @i
end	