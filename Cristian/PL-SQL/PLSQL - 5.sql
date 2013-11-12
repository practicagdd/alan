-- ----------------------------------------------------------------------------------
/* 5) Realizar un control en la tabla EQUIPO_JUGADOR que no permita dar de alta en un
equipo a un jugador que ya pertenezca a otro equipo de la misma división. */
-- ----------------------------------------------------------------------------------
CREATE TRIGGER CONTROL_JUGADOR_EQUIPO
ON EQUIPO_JUGADOR
FOR INSERT,UPDATE
AS BEGIN

DECLARE @JUGADOR int 
DECLARE @EQUIPO INT
	
DECLARE C1 CURSOR
FOR SELECT EQJU_JUGADOR, EQJU_EQUIPO FROM inserted
	
	OPEN C1
	FETCH C1 INTO @jugador, @equipo
	
	WHILE (@@FETCH_STATUS=0)
	BEGIN
		IF (dbo.JuegaEnOtroEquipoDeLaMismaDivision(@jugador, @equipo)<>0)
			BEGIN
				rollback transaction
				return
			END
			
		FETCH C1 INTO @jugador, @equipo	
	END
	
	CLOSE C1

END
-- ----------------------------------------------------------------------------------

