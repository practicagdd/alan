CREATE FUNCTION JuegaEnOtroEquipoDeLaMismaDivision(@JUGADOR INT, @EQUIPO INT)
RETURNS INT AS
BEGIN

DECLARE @CANT INT
SET @CANT = 0

SET @CANT = (SELECT COUNT(*)
			 FROM EQUIPO_JUGADOR EJ 
			 INNER JOIN EQUIPO E ON E.EQUI_CODIGO = EJ.EQJU_EQUIPO
			 
			 WHERE E.EQUI_DIVISION = (SELECT E2.EQUI_DIVISION 
									  FROM EQUIPO E2
									  WHERE E2.EQUI_CODIGO = @EQUIPO)
			AND EJ.EQJU_JUGADOR = @JUGADOR 
			AND EJ.EQJU_EQUIPO <> @EQUIPO)
			
RETURN @CANT

END 