SELECT P.PART_CODIGO, (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) AS GOLES_LOCAL,
						EL.EQUI_NOMBRE, EV.EQUI_NOMBRE,
						(SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) AS GOLES_VISITANTE,
						(CASE WHEN (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) > (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) THEN 3 
						WHEN (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) < (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) THEN 0
						ELSE 1 END) AS PUNTOS_LOCAL,
						(CASE WHEN (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) > (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) THEN 0 
						WHEN (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) < (SELECT COUNT(DP.DEPA_ACCION)
						FROM DETALLE_PARTIDO DP JOIN TIPO_ACCION TA ON DP.DEPA_ACCION = TA.TIAC_CODIGO
						WHERE DP.DEPA_PARTIDO = P.PART_CODIGO AND 
							((DP.DEPA_EQUIPO = EV.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL') OR 
							(DP.DEPA_EQUIPO = EL.EQUI_CODIGO AND TA.TIAC_DETALLE = 'GOL EN CONTRA'))
							) THEN 3
						ELSE 1 END) AS PUNTOS_VISITANTE
FROM PARTIDO P JOIN EQUIPO EL ON P.PART_LOCAL = EL.EQUI_CODIGO
			   JOIN EQUIPO EV ON P.PART_VISITANTE = EV.EQUI_CODIGO