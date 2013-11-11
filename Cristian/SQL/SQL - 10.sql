-- ---------------------------------------------------------------------------------------------------------------------------
/* 10) Mostrar para todos los partidos de la fecha 1 del torneo 1, los jugadores de ambos equipos que no se presentaron 
ordenados por NOMBRE DE EQUIPO, APELLIDO DEL JUGADOR (que no fueron ni titulares ni suplentes). El resultado se debe mostrar de
la siguiente manera: NOMBRES, APELLIDO y NOMBRE EQUIPO. */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
J.JUGA_NOMBRES 'NOMBRE',
J.JUGA_APELLIDO 'APELLIDO',
E.EQUI_NOMBRE 'EQUIPO'

FROM EQUIPO E
		 INNER JOIN EQUIPO_JUGADOR EJ ON E.EQUI_CODIGO = EJ.EQJU_EQUIPO
		 INNER JOIN JUGADOR J ON J.JUGA_DNI = EJ.EQJU_JUGADOR 
		 INNER JOIN PARTIDO P ON (E.EQUI_CODIGO = P.PART_LOCAL OR E.EQUI_CODIGO = P.PART_VISITANTE)
		 
WHERE P.PART_FECHA_TORNEO = 1 AND P.PART_TORNEO = 1 AND
      J.JUGA_DNI NOT IN (
						 SELECT JP.JUPA_JUGADOR 
						 FROM JUGADOR_PARTIDO JP
						 WHERE JP.JUPA_PARTIDO = P.PART_CODIGO
						)
ORDER BY 2,3