-- ---------------------------------------------------------------------------------------------------------------------------
/* 11) Mostrar para todos los partidos el resultado del mismo (sabiendo que las columnas PART_GOLES_LOCAL y 
PART_GOLES_VISITANTE no estan completas). El resultado se debe expresar de la siguiente manera: CODIGO DE PARTIDO, GOLES LOCAL,
EQUIPO LOCAL, GOLES VISITANTES, EQUIPO VISITANTE. Tenga en cuenta quepueden existir goles en contra. */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
P.PART_CODIGO 'CODIGO PARTIDO',
SUM(CASE WHEN ((P.PART_LOCAL = DP.DEPA_EQUIPO AND DP.DEPA_ACCION = 1) OR (P.PART_VISITANTE = DP.DEPA_EQUIPO AND DP.DEPA_ACCION = 10)) THEN 1 ELSE 0 END) 'GOLES LOCAL',
LOCAL.EQUI_NOMBRE 'LOCAL',
SUM(CASE WHEN ((P.PART_VISITANTE = DP.DEPA_EQUIPO AND DP.DEPA_ACCION = 1) OR (P.PART_LOCAL = DP.DEPA_EQUIPO AND DP.DEPA_ACCION = 10)) THEN 1 ELSE 0 END) 'GOLES VISITANTE',
VISITANTE.EQUI_NOMBRE

FROM PARTIDO P
		 INNER JOIN EQUIPO LOCAL ON P.PART_LOCAL = LOCAL.EQUI_CODIGO
		 INNER JOIN EQUIPO VISITANTE ON P.PART_VISITANTE = VISITANTE.EQUI_CODIGO
		 INNER JOIN DETALLE_PARTIDO DP ON DP.DEPA_PARTIDO = P.PART_CODIGO

GROUP BY P.PART_CODIGO,LOCAL.EQUI_NOMBRE,VISITANTE.EQUI_NOMBRE;