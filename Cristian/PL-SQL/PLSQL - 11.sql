
-- -----------------------------------------------------------------------------------------
/* 11) Escriba un funcion que dado un codigo de torneo retorne el nombre del equipo campeon.
Si hay mas de un equipo que haya obtenido la misma cantidad de puntos se retornara
"MAS DE UN CAMPEON" */
-- -----------------------------------------------------------------------------------------
CREATE FUNCTION CAMPEON (@TORNEO INT)
RETURNS VARCHAR(50) AS
BEGIN

DECLARE @PUNTOS_MAX INT
DECLARE @CAMPEON VARCHAR(50)
DECLARE @CANT_CAMPEONES INT

SET @PUNTOS_MAX = (SELECT  MAX(TP.TOPU_PUNTOS)
				   FROM dbo.TORNEO_PUNTOS TP
				   WHERE TP.TOPU_TORNEO = @TORNEO)
				   
				   
SET @CANT_CAMPEONES = (SELECT COUNT(DISTINCT TP.TOPU_EQUIPO)
					   FROM dbo.TORNEO_PUNTOS TP
					   WHERE TP.TOPU_TORNEO = @TORNEO
					   AND TP.TOPU_PUNTOS = @PUNTOS_MAX)
					   
IF @CANT_CAMPEONES > 1
	SET @CAMPEON = 'HAY MAS DE UN CAMPEON CON ' + CONVERT(VARCHAR(10),@PUNTOS_MAX) + ' PUNTOS'
ELSE
	BEGIN
		 SET @CAMPEON = (SELECT E.EQUI_NOMBRE 
		 FROM dbo.TORNEO_PUNTOS TP
		 INNER JOIN EQUIPO E ON E.EQUI_CODIGO = TP.TOPU_EQUIPO
		 WHERE TP.TOPU_TORNEO = @TORNEO
		 AND TP.TOPU_PUNTOS = @PUNTOS_MAX)
	END
				

RETURN @CAMPEON
   
END
-- -----------------------------------------------------------------------------------------

