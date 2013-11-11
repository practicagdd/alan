-- ---------------------------------------------------------------------------------------------------------------------------
/* 14) Escriba una consulta SQL que retorne la efectividad de los arqueros por partido. Para el cálculo del porcentaje se debe 
tener en cuenta los goles recibidos por el arquero durante el partido (ya sean goles a favor o en contra) y las atajadas. Por 
ejemplo si un arquero tuvo 2 atajadas y recibo un gol su efectividad en ese partido fue del 67%. Recuerde que los arqueros 
pueden ser sustituidos (se deben tener en cuenta tanto titulares como suplentes si es que ingresaron), que los tiros en los 
palos no se consideran atajadas y que la columna jupa_atajadas de la tabla jugador_partido no esta completa. */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
J.JUGA_APELLIDO 'APELLIDO',
J.JUGA_NOMBRES 'NOMBRES',
J.JUGA_DNI 'DNI',
E.EQUI_NOMBRE 'EQUIPO',
DP.DEPA_PARTIDO 'PARTIDO',
SUM(CASE WHEN (DP.DEPA_CODIGO = 6) THEN 1 ELSE 0 END)'ATAJADAS',
SUM(CASE WHEN ((P.PART_LOCAL = DP.DEPA_EQUIPO AND DP.DEPA_ACCION = 10) OR (P.PART_VISITANTE = DP.DEPA_EQUIPO AND DP.DEPA_ACCION = 1)) THEN 1 ELSE 0 END)'GOLES RECIBIDOS',

((SUM(CASE WHEN (DP.DEPA_CODIGO = 6) THEN 1 ELSE 0 END) / CASE WHEN(SUM(CASE WHEN ((P.PART_LOCAL = DP.DEPA_EQUIPO AND DP.DEPA_ACCION = 10) OR (P.PART_VISITANTE = DP.DEPA_EQUIPO AND DP.DEPA_ACCION = 1)) THEN 1 ELSE 0 END)) = 0 THEN 1 END)*100) 'EFECTIVIDAD'

FROM JUGADOR J
		 INNER JOIN JUGADOR_PARTIDO JP ON JP.JUPA_JUGADOR = J.JUGA_DNI
		 INNER JOIN EQUIPO E ON E.EQUI_CODIGO = JP.JUPA_EQUIPO 
		 INNER JOIN DETALLE_PARTIDO DP ON DP.DEPA_PARTIDO = JP.JUPA_PARTIDO 
		 INNER JOIN PARTIDO P ON P.PART_CODIGO = DP.DEPA_CODIGO

WHERE JP.JUPA_POSICION = 'ARQ'
GROUP BY DP.DEPA_PARTIDO, J.JUGA_APELLIDO, J.JUGA_NOMBRES, J.JUGA_DNI, E.EQUI_NOMBRE
-- ---------------------------------------------------------------------------------------------------------------------------