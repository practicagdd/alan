-- ------------------------------------------------------------------------------------
/* 13)  Codifique una función para que dado un nro de DNI (de un director técnico) y un
porcentaje, retorne los premios que gano durante todo su carrera suponiendo que le
corresponde el porcentaje ingresado como parametro de cada premio que haya ganado un
equipo dirigido por él. Se supone que en la tabla premio, en la columna prem_detalle
esta cargado una suma de dinero como tipo string.Se supone que un director técnico
dirige un único equipo por torneo */ 
-- ------------------------------------------------------------------------------------
CREATE FUNCTION PREMIOS_DT (@DNI VARCHAR(8), @PORCENTAJE FLOAT)
RETURNS FLOAT AS
BEGIN

DECLARE @PREMIO FLOAT

SET @PREMIO = (SELECT SUM(CONVERT(float,PREM_DETALLE)) * @PORCENTAJE / 100

FROM TABLA_POSICIONES TP
	 INNER JOIN EQUIPO E ON E.EQUI_CODIGO = TP.TAPO_EQUIPO
	 INNER JOIN TORNEO T ON T.TORN_CODIGO = TP.TAPO_TORNEO
	 INNER JOIN PREMIO P ON P.PREM_CODIGO = (CASE TP.TAPO_POSICION
					WHEN 1 THEN T.TORN_PRIMER_PREMIO
					WHEN 2 THEN T.TORN_SEGUNDO_PREMIO
					WHEN 3 THEN T.TORN_TERCER_PREMIO
					END)
WHERE E.EQUI_DT = @DNI AND TP.TAPO_POSICION IN (1,2,3))

RETURN @PREMIO

END
-- ------------------------------------------------------------------------------------
