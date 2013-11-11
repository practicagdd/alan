/* 3) Mostrar la primera fecha del torneo de la división A, ordenado cronológicamente. En la consulta se deberá distinguir el 
local y el visitante. El nombre y apellido del árbitro deberá aparecer como "APELLIDO, NOMBRES" en una UNICA columna. */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
LOCAL.EQUI_NOMBRE 'LOCAL',
VISITANTE.EQUI_NOMBRE 'VISITANTE',
(A.ARBI_APELLIDO + ', ' + A.ARBI_NOMBRES) 'ARBITRO' 

FROM TORNEO T 
     INNER JOIN PARTIDO P ON P.PART_TORNEO = T.TORN_CODIGO
     INNER JOIN EQUIPO LOCAL ON P.PART_LOCAL = LOCAL.EQUI_CODIGO 
     INNER JOIN EQUIPO VISITANTE ON P.PART_VISITANTE = VISITANTE.EQUI_CODIGO
     INNER JOIN ARBITRO A ON A.ARBI_DNI = P.PART_ARBITRO 
     
WHERE P.PART_FECHA_TORNEO = 1 AND T.TORN_DIVISION = 'A'
ORDER BY P.PART_FECHA_HORA;