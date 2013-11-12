USE torneo
GO 

SELECT JUGA_APELLIDO, JUGA_NOMBRES, JUGA_DNI, EQUI_NOMBRE, A.JUPA_PARTIDO,
		SUM(CASE WHEN DA.DEPA_ACCION = 6 AND DA.DEPA_JUGADOR=A.JUPA_JUGADOR THEN 1 ELSE 0 END),
		SUM(CASE WHEN ((DA.DEPA_EQUIPO= A.JUPA_EQUIPO AND DA.DEPA_ACCION = 1) OR (DA.DEPA_EQUIPO <> A.JUPA_EQUIPO AND DA.DEPA_ACCION = 10)) AND DA.DEPA_MINUTO > ISNULL(DAE.DEPA_MINUTO, -1) AND DA.DEPA_MINUTO < ISNULL(DAE.DEPA_MINUTO, 180) THEN 1 ELSE 0 END),
		
		(CASE WHEN
			SUM(CASE WHEN DA.DEPA_ACCION = 6 AND DA.DEPA_JUGADOR=A.JUPA_JUGADOR THEN 1 ELSE 0 END) = 0 THEN 0
		ELSE
			(
			CONVERT(FLOAT, SUM(CASE WHEN DA.DEPA_ACCION = 6 AND DA.DEPA_JUGADOR=A.JUPA_JUGADOR THEN 1 ELSE 0 END)) / 
			(SUM(CASE WHEN DA.DEPA_ACCION = 6 AND DA.DEPA_JUGADOR=A.JUPA_JUGADOR THEN 1 ELSE 0 END) +
			SUM(CASE WHEN ((DA.DEPA_EQUIPO= A.JUPA_EQUIPO AND DA.DEPA_ACCION = 1) OR (DA.DEPA_EQUIPO <> A.JUPA_EQUIPO AND DA.DEPA_ACCION = 10)) AND DA.DEPA_MINUTO > ISNULL(DAE.DEPA_MINUTO, -1) AND DA.DEPA_MINUTO < ISNULL(DAE.DEPA_MINUTO, 180) THEN 1 ELSE 0 END))
			)*100
		END
		)
		
		
		
FROM JUGADOR_PARTIDO A
JOIN JUGADOR ON JUGA_DNI = JUPA_JUGADOR
JOIN EQUIPO ON EQUI_CODIGO = JUPA_EQUIPO
JOIN DETALLE_PARTIDO DA ON DA.DEPA_PARTIDO = JUPA_PARTIDO
-- LEFT JOIN JUGADOR_PARTIDO B ON A.JUPA_PARTIDO = B.JUPA_PARTIDO AND B.JUPA_POSICION = 'ARQ' AND A.JUPA_JUGADOR <> B.JUPA_JUGADOR AND A.JUPA_EQUIPO = B.JUPA_EQUIPO
LEFT JOIN DETALLE_PARTIDO DAE ON DAE.DEPA_PARTIDO = A.JUPA_PARTIDO AND DAE.DEPA_JUGADOR = A.JUPA_JUGADOR AND DAE.DEPA_ACCION = 5
LEFT JOIN DETALLE_PARTIDO DAS ON DAS.DEPA_PARTIDO = A.JUPA_PARTIDO AND DAS.DEPA_JUGADOR = A.JUPA_JUGADOR AND DAS.DEPA_ACCION = 11
WHERE A.JUPA_POSICION = 'ARQ' 
GROUP BY JUGA_APELLIDO, JUGA_NOMBRES, JUGA_DNI, EQUI_NOMBRE, A.JUPA_PARTIDO

ORDER BY 8 DESC, 6 DESC, 7 ASC