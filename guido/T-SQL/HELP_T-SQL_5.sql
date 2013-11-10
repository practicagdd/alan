CREATE FUNCTION juegaEnOtroEquipoDeLaDivision(@dnijugador int, @codEquipo int)
returns int
begin
	DECLARE @cant INT
	set @cant = 0
	SELECT @cant = COUNT(*) FROM EQUIPO_JUGADOR EJ
	JOIN EQUIPO E ON E.EQUI_CODIGO = EJ.EQJU_EQUIPO
	WHERE E.EQUI_DIVISION = (
		SELECT EQUI_DIVISION FROM EQUIPO
		WHERE EQUIPO.EQUI_CODIGO = @codEquipo
		)									/*que sea misma division*/
		AND ej.EQJU_JUGADOR = @dnijugador /*QUE SEA EL MISMO JUGADOR*/
		AND ej.EQJU_EQUIPO <> @codEquipo /*EN OTRO EQUIPO*/
	return @cant
end