CREATE FUNCTION duracionEntreTiempo (@codigopartido int)
returns int
BEGIN
	DECLARE @cantMinutos int
	SELECT @cantMinutos = (PART_DURACION - 40 - PART_ADICIONAL) 
						FROM PARTIDO WHERE PART_CODIGO = @codigopartido
	RETURN @cantMinutos
END

GO

