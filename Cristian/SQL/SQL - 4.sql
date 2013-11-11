/* 4) Obtener el plantel completo (DNI, APELLIDO, NOMBRES Y NOMBRE DE POSICION FAVORITA) del equipo NEWELLS, sin conocer el 
código de equipo */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
J.JUGA_DNI 'DNI',
J.JUGA_APELLIDO 'APELLIDO',
J.JUGA_NOMBRES 'NOMBRES',
P.POSI_DETALLE 'POSICION FAVORITA' 

FROM EQUIPO_JUGADOR EJ
		 INNER JOIN JUGADOR J ON J.JUGA_DNI = EJ.EQJU_JUGADOR
		 INNER JOIN EQUIPO E ON EJ.EQJU_EQUIPO = E.EQUI_CODIGO 
		 INNER JOIN POSICION P ON P.POSI_CODIGO = J.JUGA_POSICION_FAVORITA
WHERE E.EQUI_CODIGO = (SELECT TOP 1 EQUI_CODIGO FROM EQUIPO WHERE EQUI_NOMBRE = 'NEWELLS')