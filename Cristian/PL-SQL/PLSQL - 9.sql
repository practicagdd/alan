/* (9 Crear un stored procedure que actualice la posición favorita del jugador, si ha jugado
más veces en otra posición. */
-- -----------------------------------------------------------------------------------------
CREATE PROCEDURE ACTUALIZAR_POSICION
AS
BEGIN

UPDATE JUGADOR SET JUGA_POSICION_FAVORITA = dbo.POSICION_MAS_JUGADA(JUGA_DNI)
WHERE JUGA_POSICION_FAVORITA <> dbo.POSICION_MAS_JUGADA(JUGA_DNI)

END
-- -----------------------------------------------------------------------------------------
