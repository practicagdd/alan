CREATE TRIGGER controloJugadorPartido
on DETALLE_PARTIDO
FOR INSERT
AS
BEGIN
	DECLARE @codAccion INT
	DECLARE @codPartido INT
	DECLARE @codJugador INT
	DECLARE C3 CURSOR
	FOR SELECT DEPA_ACCION, DEPA_PARTIDO, DEPA_JUGADOR FROM inserted
	OPEN C3
	FETCH C3 INTO @codAccion, @codPartido, @codJugador
	
	WHILE (@@FETCH_STATUS=0)
	begin
		if (@codAccion=1) /*GOL*/
		begin
			UPDATE JUGADOR_PARTIDO SET JUPA_GOLES_CONVERTIDOS=
			(select jp.JUPA_GOLES_CONVERTIDOS from JUGADOR_PARTIDO jp
			WHERE jp.JUPA_JUGADOR = @codJugador) +1	
		end
		if (@codAccion=10) /*GOL EN CONTRA*/
		begin
			UPDATE JUGADOR_PARTIDO SET JUPA_GOLES_ENCONTRA=
			(select jp.JUPA_GOLES_ENCONTRA from JUGADOR_PARTIDO jp
			WHERE jp.JUPA_JUGADOR = @codJugador) +1	
		end
		
		FETCH C3 INTO @codAccion, @codPartido, @codJugador
	end
	
	CLOSE C3
END
