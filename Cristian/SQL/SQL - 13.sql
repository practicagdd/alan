-- ---------------------------------------------------------------------------------------------------------------------------
/* 13) Retornar para todas las persona que hayan sido jugador, técnico y árbitro (no necesariamente a la vez) las siguientes 
columnas:
a. DNI.
b. Apellido, Nombres.
c. Cantidad de partidos como jugador titular.
d. Cantidad de partidos como árbitro en los que haya obtenido una calificación BUENO ó MUY BUENO.
e. Cantidad de partidos en los que fue técnico y jugador a la vez.
f. Actividad predominante (‘JUGADOR TITULAR’,’ARBITRO CORRECTO’,’TECNICO JUGADOR’). Según los valores obtenidos en las columnas
3 a 5.
Ninguna de las columnas puede retornar NULL.
El resultado debe ser ordenado por el promedio de calificación obtenido como árbitro. */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
J.JUGA_DNI 'DNI',
J.JUGA_APELLIDO + ', ' + J.JUGA_NOMBRES 'APELLIDO, NOMBRES',
(SELECT COUNT(*) FROM JUGADOR_PARTIDO JP WHERE JP.JUPA_JUGADOR = J.JUGA_DNI AND JP.JUPA_TITULAR = 'S') 'PARTIDOS TITULAR',
(SELECT COUNT(*) FROM PARTIDO P WHERE A.ARBI_DNI = P.PART_ARBITRO AND P.PART_CALIF_ARBITRO IN (1,2)) 'PARTIDOS CALIF BUENO O MUY BUENO',
(SELECT COUNT(*) FROM PARTIDO P 
 INNER JOIN JUGADOR_PARTIDO JP ON JP.JUPA_PARTIDO = P.PART_CODIGO
 INNER JOIN EQUIPO E ON (E.EQUI_CODIGO = P.PART_LOCAL OR E.EQUI_CODIGO = P.PART_VISITANTE)	
 WHERE JP.JUPA_JUGADOR= DT.DITE_DNI AND E.EQUI_DT = DT.DITE_DNI) 'PARTIDOS DT Y JUGADOR'
 
 /* EL PUNTO F ES HACER UN CASE GRANDE COPIANDO Y PEGANDO LAS COLUMNAS 3 A 5 */
 
FROM DIRECTOR_TECNICO DT
		 INNER JOIN JUGADOR J ON J.JUGA_DNI = DT.DITE_DNI
		 INNER JOIN ARBITRO A ON A.ARBI_DNI = DT.DITE_DNI
		 
ORDER BY 4