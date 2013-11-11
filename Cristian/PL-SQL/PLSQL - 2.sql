-- ----------------------------------------------------------------------------------------------------------
/* 2) Crear una función que, a partir de un número de DNI,un código de lesion y el partido en que se lesionó 
devuelva el número de fecha del torneo en que el jugador ya estaría habilitado para jugar nuevamente. Si la 
fecha es mayor a la última del torneo, devolver -1, si el jugador no ha sufrido lesion devolver 0.
Tener en cuenta que la recuperación de lesión está expresada en DIAS en la base de datos, y no en FECHAS. 
Considerar que hay una fecha cada 7 dias. */
-- ----------------------------------------------------------------------------------------------------------
CREATE FUNCTION FECHA_REGRESO (@DNI VARCHAR(8),@COD_LESION INT,@PARTIDO INT)
RETURNS INT AS
BEGIN

DECLARE @FECHA INT
SET @FECHA = (SELECT (LJ.LEJU_FECHA_TORNEO + DBO.CONVERTIR_DIAS_A_FECHATORNEO(TL.TILE_DIAS_RECUPERACION))
										 FROM LESION_JUGADOR LJ
										 INNER JOIN TIPO_LESION TL ON TL.TILE_CODIGO = LJ.LEJU_LESION 
										 WHERE LJ.LEJU_JUGADOR = @DNI AND LJ.LEJU_PARTIDO = @PARTIDO
										 AND LJ.LEJU_LESION = @COD_LESION)
										 
IF @FECHA IS NULL
		RETURN 0
ELSE
	BEGIN
	IF @FECHA > (SELECT T.TORN_CANTIDAD_FECHAS
							 FROM TORNEO T 
							 WHERE T.TORN_CODIGO = (SELECT P.PART_TORNEO
							 												FROM PARTIDO P 
																			WHERE P.PART_CODIGO = @PARTIDO))
	    RETURN -1
	ELSE
			RETURN @FECHA
	END
	
RETURN 1
END
-- ----------------------------------------------------------------------------------------------------------
CREATE FUNCTION CONVERTIR_DIAS_A_FECHATORNEO (@DIAS INT)
RETURNS INT AS 
BEGIN
DECLARE @RESTO INT
SET @RESTO = @DIAS % 7
IF @RESTO > 0
	RETURN(CEILING(@DIAS/7)+1)
ELSE
	RETURN CEILING(@DIAS/7)
	
RETURN 1 -- LO PONGO PORQUE SINO TIRA ERROR DE SINTAXIS, NUNCA PASA POR ACA.
END
-- ----------------------------------------------------------------------------------------------------------