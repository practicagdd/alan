-- ---------------------------------------------------------------------------------------------------------------------------
/* 6) Obtener la cantidad de goles de todos los jugadores existentes, a partir del detalle del partido, sabiendo que la 
columna JUPA_GOLES_CONVERTIDOS no posee datos */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
J.JUGA_DNI 'JUGADOR',
(J.JUGA_APELLIDO + ', ' + J.JUGA_NOMBRES) 'NOMBRE',
COUNT(DP.DEPA_ACCION) 'GOLES'

FROM DETALLE_PARTIDO DP
		 INNER JOIN JUGADOR J ON J.JUGA_DNI = DP.DEPA_JUGADOR
		 INNER JOIN TIPO_ACCION TA ON TA.TIAC_CODIGO = DP.DEPA_ACCION
WHERE TA.TIAC_DETALLE = 'GOL'
GROUP BY J.JUGA_DNI, J.JUGA_APELLIDO, J.JUGA_NOMBRES
ORDER BY 3 DESC,2