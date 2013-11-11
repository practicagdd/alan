-- ---------------------------------------------------------------------------------------------------------------------------
 /* 5) Obtener el jugador más pesado que haya jugado en la fecha 1 del torneo división B. Mostrar DNI, APELLIDO, NOMBRES, PESO,
EQUIPO Y NUMERO DE PARTIDO */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT TOP 1
J.JUGA_DNI 'DNI',
J.JUGA_NOMBRES 'NOMBRE',
J.JUGA_APELLIDO 'APELLIDO',
J.JUGA_PESO 'PESO',
P.PART_CODIGO 'NUMERO DE PARTIDO',
E.EQUI_NOMBRE 'EQUIPO'

FROM PARTIDO P
	   INNER JOIN TORNEO T ON T.TORN_CODIGO = P.PART_TORNEO
	   INNER JOIN JUGADOR_PARTIDO JP ON JP.JUPA_PARTIDO = P.PART_CODIGO
	   INNER JOIN JUGADOR J ON J.JUGA_DNI = JP.JUPA_JUGADOR
	   INNER JOIN EQUIPO E ON E.EQUI_CODIGO = JP.JUPA_EQUIPO
	   
WHERE T.TORN_DIVISION = 'B' AND P.PART_FECHA_TORNEO = 1
ORDER BY J.JUGA_PESO DESC;