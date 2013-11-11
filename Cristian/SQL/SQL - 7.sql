-- ---------------------------------------------------------------------------------------------------------------------------
 /* 7) Obtener APELLIDO, NOMBRES Y CANTIDAD DE ENCUENTROS DIRIGIDOS de los árbitros que hayan o estén asignados a dirigir a 
 SAN LORENZO 2 o más veces, ordenado alfabéticamente por apellido */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
A.ARBI_DNI 'DNI',
A.ARBI_APELLIDO 'APELLIDO',
A.ARBI_NOMBRES 'NOMBRE',
COUNT(*) 'ENCUENTROS DIRIGIDOS'

FROM PARTIDO P
		 INNER JOIN ARBITRO A ON A.ARBI_DNI = P.PART_ARBITRO
WHERE (
		SELECT COUNT(*)
		FROM PARTIDO P 
		JOIN EQUIPO E ON (P.PART_LOCAL = E.EQUI_CODIGO OR P.PART_VISITANTE = E.EQUI_CODIGO)
		WHERE (E.EQUI_NOMBRE ='SAN LORENZO') AND P.PART_ARBITRO= A.ARBI_DNI
	) > 1		  
GROUP BY A.ARBI_DNI, A.ARBI_APELLIDO, A.ARBI_NOMBRES
ORDER BY 2,3