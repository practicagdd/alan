CREATE FUNCTION CANTIDAD_VECES_CAMPEON (@jugador int)
RETURNS int AS 
BEGIN
	RETURN (
		SELECT COUNT(*)
		FROM EQUIPO_JUGADOR
		JOIN TABLA_POSICIONES ON TAPO_POSICION = 1 AND EQJU_EQUIPO = TAPO_EQUIPO
		WHERE EQJU_JUGADOR = @jugador
			)
END