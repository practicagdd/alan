CREATE PROCEDURE ActualizarPosFavoritaDeJugadores
AS
BEGIN
	UPDATE JUGADOR
	SET JUGA_POSICION_FAVORITA=dbo.posicionMasVeces(JUGA_DNI)
END
