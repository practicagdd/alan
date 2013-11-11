-- ---------------------------------------------------------------------------------------------------------------------------
/* 2) Mostrar el DNI, NOMBRES, APELLIDO, EDAD y EQUIPO de los directores técnicos que también se desempeñen como jugador en su 
equipo, ordenado alfabéticamente por apellido */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT 
DT.DITE_DNI 'DNI',
DT.DITE_NOMBRES 'NOMBRES',
DT.DITE_APELLIDO 'APELLIDO',
DT.DITE_EDAD 'EDAD',
E.EQUI_NOMBRE 'EQUIPO'

FROM DIRECTOR_TECNICO DT 
		 INNER JOIN EQUIPO E ON DT.DITE_DNI = E.EQUI_DT
		 INNER JOIN EQUIPO_JUGADOR EJ ON EJ.EQJU_JUGADOR = DT.DITE_DNI 																																AND EJ.EQJU_EQUIPO = E.EQUI_CODIGO
ORDER BY DT.DITE_APELLIDO ASC;
-- ---------------------------------------------------------------------------------------------------------------------------