/* 12) Codifique el/los objetos de base de datos necesarios para que el campo juga_promedio de
la tabla Jugador se mantenga actualizado automáticamente a partir de los valores del
campo jupa_calificacion de la tabla Jugador_partido. Se sabe que sobre la tabla
Jugador_partido se puede realizar cualquier tipo de acción, tanto individual como masiva  */
-- -------------------------------------------------------------------------------------------
CREATE TRIGGER ACTUALIZAR_PROMEDIO
ON JUGADOR_PARTIDO
FOR INSERT,UPDATE,DELETE
AS
BEGIN

	UPDATE JUGADOR SET JUGA_PROMEDIO = (SELECT AVG(JP.JUPA_CALIFICACION)
										FROM JUGADOR_PARTIDO JP 
										WHERE  JP.JUPA_JUGADOR = JUGA_DNI)
	
	WHERE JUGA_DNI IN (SELECT I.JUPA_JUGADOR  FROM inserted I
						UNION
					   SELECT  D.JUPA_JUGADOR  FROM deleted D)


END
-- -------------------------------------------------------------------------------------------
