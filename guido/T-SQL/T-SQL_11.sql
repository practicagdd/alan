CREATE FUNCTION equipoCampeon(@codTorneo int)
returns varchar(50)
begin
	DECLARE @Puntosmax int
	SELECT top 1  @Puntosmax = SUM(PUNTOS) from Dbo.partidos_puntos
	WHERE TORN_CODIGO = @codTorneo
	group by EQUI_NOMBRE
	order by sum(puntos) desc
	
	DECLARE @campeon varchar(50)
	DECLARE @cantCampeones int
	
	
	SELECT @campeon = EQUI_NOMBRE FROM dbo.partidos_puntos
	WHERE TORN_CODIGO = @codTorneo
	GROUP BY EQUI_NOMBRE
	having SUM(puntos) = @Puntosmax
	ORDER BY SUM(PUNTOS) DESC
	
	IF (@@ROWCOUNT>1)
		set @campeon = 'hay mas de uno'
		
	return @campeon
end