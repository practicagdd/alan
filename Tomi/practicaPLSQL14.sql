CREATE FUNCTION cantidad_veces_campeon (@dni varchar(8)) RETURNS int
AS BEGIN

DECLARE @cant int
SET @cant = (SELECT COUNT(*)
			 FROM TORNEO_EQUIPO TE JOIN EQUIPO E ON TE.TOEQ_EQUIPO = E.EQUI_CODIGO
									JOIN EQUIPO_JUGADOR EJ ON EJ.EQJU_EQUIPO = E.EQUI_CODIGO
									JOIN JUGADOR J ON J.JUGA_DNI = EJ.EQJU_JUGADOR AND J.JUGA_DNI = @dni
			 WHERE TE.TOEQ_MEJOR_POSICION = 1)			 
RETURN @cant
END