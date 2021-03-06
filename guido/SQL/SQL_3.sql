SELECT Convert(Varchar(10),p.PART_FECHA_HORA,103),
ELOCAL.EQUI_NOMBRE AS LOCAL,
P.PART_GOLES_LOCAL AS GOLESLOCAL,
EVISITANTE.EQUI_NOMBRE AS VISITANTE,
P.PART_GOLES_VISITANTE AS GOLESVISITANTE, division.DIVI_DETALLE,
A.ARBI_APELLIDO + ', ' + A.ARBI_NOMBRES AS NOMAPE
FROM PARTIDO P
JOIN EQUIPO ELOCAL ON P.PART_LOCAL = ELOCAL.EQUI_CODIGO
JOIN EQUIPO EVISITANTE ON P.PART_VISITANTE = EVISITANTE.EQUI_CODIGO
JOIN ARBITRO A ON A.ARBI_DNI = P.PART_ARBITRO
JOIN TORNEO ON P.PART_TORNEO=TORNEO.TORN_CODIGO
JOIN DIVISION ON TORNEO.TORN_DIVISION = DIVISION.DIVI_CODIGO
WHERE DIVISION.DIVI_DETALLE='PRIMERA CATEGOR�A - DIVISION A' 
AND   P.PART_FECHA_TORNEO= 1