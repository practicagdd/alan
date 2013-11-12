-- ---------------------------------------------------------------------------------------------------------------------------
/* 14) Escriba una consulta SQL que retorne la efectividad de los arqueros por partido. Para el cálculo del porcentaje se debe 
tener en cuenta los goles recibidos por el arquero durante el partido (ya sean goles a favor o en contra) y las atajadas. Por 
ejemplo si un arquero tuvo 2 atajadas y recibo un gol su efectividad en ese partido fue del 67%. Recuerde que los arqueros 
pueden ser sustituidos (se deben tener en cuenta tanto titulares como suplentes si es que ingresaron), que los tiros en los 
palos no se consideran atajadas y que la columna jupa_atajadas de la tabla jugador_partido no esta completa. */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT JUGA_APELLIDO, JUGA_NOMBRES, JUGA_DNI, EQUI_NOMBRE, A.JUPA_PARTIDO,
		SUM(CASE WHEN DA.DEPA_ACCION = 6 AND DA.DEPA_JUGADOR=A.JUPA_JUGADOR THEN 1 ELSE 0 END) 'ATAJADAS',
		SUM(CASE WHEN ((DA.DEPA_EQUIPO= A.JUPA_EQUIPO AND DA.DEPA_ACCION = 10) OR (DA.DEPA_EQUIPO <> A.JUPA_EQUIPO AND DA.DEPA_ACCION = 1)) AND DA.DEPA_MINUTO > ISNULL(DAE.DEPA_MINUTO, -1) AND DA.DEPA_MINUTO < ISNULL(DAE.DEPA_MINUTO, 180) THEN 1 ELSE 0 END) 'GOLES RECIBIDOS',
		
		(CASE WHEN
			SUM(CASE WHEN DA.DEPA_ACCION = 6 AND DA.DEPA_JUGADOR=A.JUPA_JUGADOR THEN 1 ELSE 0 END) = 0 THEN 0
		ELSE
			(
			CONVERT(FLOAT, SUM(CASE WHEN DA.DEPA_ACCION = 6 AND DA.DEPA_JUGADOR=A.JUPA_JUGADOR THEN 1 ELSE 0 END)) / 
			(SUM(CASE WHEN DA.DEPA_ACCION = 6 AND DA.DEPA_JUGADOR=A.JUPA_JUGADOR THEN 1 ELSE 0 END) +
			SUM(CASE WHEN ((DA.DEPA_EQUIPO= A.JUPA_EQUIPO AND DA.DEPA_ACCION = 10) OR (DA.DEPA_EQUIPO <> A.JUPA_EQUIPO AND DA.DEPA_ACCION = 1)) AND DA.DEPA_MINUTO > ISNULL(DAE.DEPA_MINUTO, -1) AND DA.DEPA_MINUTO < ISNULL(DAE.DEPA_MINUTO, 180) THEN 1 ELSE 0 END))
			)*100
		END
		) 'EFECTIVIDAD'
		
		
		
FROM JUGADOR_PARTIDO A
JOIN JUGADOR ON JUGA_DNI = JUPA_JUGADOR
JOIN EQUIPO ON EQUI_CODIGO = JUPA_EQUIPO
JOIN DETALLE_PARTIDO DA ON DA.DEPA_PARTIDO = JUPA_PARTIDO
LEFT JOIN DETALLE_PARTIDO DAE ON DAE.DEPA_PARTIDO = A.JUPA_PARTIDO AND DAE.DEPA_JUGADOR = A.JUPA_JUGADOR AND DAE.DEPA_ACCION = 5
LEFT JOIN DETALLE_PARTIDO DAS ON DAS.DEPA_PARTIDO = A.JUPA_PARTIDO AND DAS.DEPA_JUGADOR = A.JUPA_JUGADOR AND DAS.DEPA_ACCION = 11
WHERE A.JUPA_POSICION = 'ARQ' 
GROUP BY JUGA_APELLIDO, JUGA_NOMBRES, JUGA_DNI, EQUI_NOMBRE, A.JUPA_PARTIDO

ORDER BY 8 DESC, 6 DESC, 7 ASC
-- ---------------------------------------------------------------------------------------------------------------------------