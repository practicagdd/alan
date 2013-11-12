-- -----------------------------------------------------------------------------------------------------------------------------------------------
/* TRIGGER QUE ACTUALIZA LA MEJOR POSICION DE UN EQUIPO EN LA TABLA TORNEO_EQUIPO, USANDO LA VISA TABLA_POSICIONES. TRIGGER SOBRE TABLA PARTIDO */
-- -----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER ACTUALIZAR_MEJOR_POSICION 
ON PARTIDO
AFTER UPDATE, INSERT AS
BEGIN 

IF (UPDATE(PART_DURACION))
	BEGIN
		UPDATE TORNEO_EQUIPO SET TOEQ_MEJOR_POSICION = (SELECT (CASE 
																WHEN TAPO_POSICION >= TOEQ_MEJOR_POSICION 
																THEN TAPO_POSICION 
																ELSE TOEQ_MEJOR_POSICION 
																END)
		
														FROM TABLA_POSICIONES TP
														WHERE TP.TAPO_TORNEO = TOEQ_TORNEO AND TOEQ_EQUIPO = TP.TAPO_EQUIPO)
	
		WHERE TOEQ_EQUIPO IN (SELECT PART_LOCAL FROM inserted UNION SELECT PART_VISITANTE FROM inserted)
		
	END	
	
END
-- -----------------------------------------------------------------------------------------------------------------------------------------------
