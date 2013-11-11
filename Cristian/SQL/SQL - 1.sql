-- ---------------------------------------------------------------------------------------------------------------------------
/* 1) Mostrar para cada período mensual (YYYYMM) cuantas lesiones hubo y en cuantos partidos hubo lesionados en dicho período.
Los datos se deben mostrar por período ascendente */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT 
(YEAR(LEJU_FECHA_REAL)*100 + MONTH(LEJU_FECHA_REAL)) 'PERIODO',
COUNT(*) 'LESIONES', 
COUNT(DISTINCT LEJU_PARTIDO) 'PARTIDOS CON LESIONES'

FROM LESION_JUGADOR
GROUP BY (YEAR(LEJU_FECHA_REAL)*100 + MONTH(LEJU_FECHA_REAL))
ORDER BY 1 ASC;