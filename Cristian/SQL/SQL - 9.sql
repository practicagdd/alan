-- ---------------------------------------------------------------------------------------------------------------------------
/* 9) Mostrar el NOMBRE de todos los equipos contra los que se enfrentó o se deberá enfrentar el jugador con DNI 22880605 */
-- ---------------------------------------------------------------------------------------------------------------------------
/* Equipos contra los que SE ENFRENTO EN EL PASADO */
(SELECT
DISTINCT E.EQUI_NOMBRE 'EQUIPO' 

FROM EQUIPO E
		 INNER JOIN EQUIPO_JUGADOR EJ ON EJ.EQJU_EQUIPO = E.EQUI_CODIGO
		 INNER JOIN JUGADOR_PARTIDO JP ON JP.JUPA_EQUIPO = EJ.EQJU_EQUIPO 
		 
WHERE JP.JUPA_JUGADOR = '22880605' AND 
JP.JUPA_EQUIPO NOT IN (
						SELECT E2.EQUI_CODIGO 
						FROM EQUIPO E2
						JOIN EQUIPO_JUGADOR EJ2 ON (EJ2.EQJU_EQUIPO = E2.EQUI_CODIGO AND 																						                 EJ.EQJU_JUGADOR = '22880605')
					   )
)UNION(
/* Equipos contra los que se VA A ENFRENTAR EN EL FUTURO */
SELECT
DISTINCT E.EQUI_NOMBRE 'EQUIPO' 

FROM EQUIPO E
		 INNER JOIN EQUIPO_JUGADOR EJ ON EJ.EQJU_EQUIPO = E.EQUI_CODIGO
		 INNER JOIN PARTIDO P ON (P.PART_LOCAL = E.EQUI_CODIGO OR P.PART_VISITANTE = E.EQUI_CODIGO)
		 
WHERE EJ.EQJU_JUGADOR  = '22880605' AND
E.EQUI_CODIGO NOT IN (
					  SELECT E2.EQUI_CODIGO 
				      FROM EQUIPO E2
			          JOIN EQUIPO_JUGADOR EJ2 ON (EJ2.EQJU_EQUIPO = E2.EQUI_CODIGO AND 																														 EJ.EQJU_JUGADOR = '22880605')
					  )
)