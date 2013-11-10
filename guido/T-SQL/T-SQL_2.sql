CREATE FUNCTION cuandoEstaHabilitado(@dni int, @codLesion int, @codPartido int)
returns int
begin
declare @cantFechasHabilitado int
declare @diasRecupero int
declare @fechaLesion int
declare @cantFechasTorneo int

	SELECT	@diasRecupero =  TL.TILE_DIAS_RECUPERACION, 
			@fechaLesion = p.PART_FECHA_TORNEO,
			@cantFechasTorneo = t.TORN_CANTIDAD_FECHAS
	FROM TIPO_LESION TL
		JOIN LESION_JUGADOR LJ ON LJ.LEJU_LESION=TL.TILE_CODIGO
		JOIN PARTIDO P ON P.PART_CODIGO = LJ.LEJU_PARTIDO 
		JOIN TORNEO T ON T.TORN_CODIGO = P.PART_TORNEO
	WHERE lj.LEJU_JUGADOR = @dni and tl.TILE_CODIGO=@codLesion
	 and p.PART_CODIGO = @codPartido
	 
	set @cantFechasHabilitado = @fechaLesion + round(@diasRecupero/7,0)
	IF (@cantFechasHabilitado>@cantFechasTorneo) 
		SET @cantFechasHabilitado = -1
		
	return @cantFechasHabilitado	 
end