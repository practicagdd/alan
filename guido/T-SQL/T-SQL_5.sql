CREATE TRIGGER controloJugador
on EQUIPO_JUGADOR
FOR INSERT,UPDATE
AS
BEGIN
	DECLARE @jugador int 
	DECLARE @equipo int
	DECLARE C1 CURSOR
	FOR SELECT EQJU_JUGADOR, EQJU_EQUIPO FROM inserted
	OPEN C1
	FETCH C1 INTO @jugador, @equipo
	
	WHILE (@@FETCH_STATUS=0)
	begin
		if (dbo.juegaEnOtroEquipoDeLaDivision(@jugador, @equipo)<>0)
			rollback transaction
			return
		FETCH C1 INTO @jugador, @equipo	
	end
	
	CLOSE C1
END
