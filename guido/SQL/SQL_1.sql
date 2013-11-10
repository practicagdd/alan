SELECT YEAR(leju_fecha_real)*100 + MONTH(LEJU_FECHA_REAL) as periodo,
COUNT(leju_jugador) as cantJugadores,
COUNT(distinct leju_partido)
 from LESION_JUGADOR
 group by YEAR(leju_fecha_real)*100 + MONTH(LEJU_FECHA_REAL)
 order by YEAR(leju_fecha_real)*100 + MONTH(LEJU_FECHA_REAL) asc
 
 /*VER POR PERIODOS MENSUAL LA CANTIDAD DE LESIONES Y EN CUANTOS
 PARTIDOS HUBO LESIONADOS*/