--Depende de TORNEO_PUNTOS.
--Esta vista, tiene una fila por equipo por torneo y cuenta con todos los datos de TORNEO_PUNTOS. 
--Agrega la posicion de cada equipo para cada torneo.

CREATE VIEW TABLA_POSICIONES (TAPO_TORNEO, TAPO_EQUIPO, TAPO_POSICION, TAPO_PARTIDOS, TAPO_FECHAS_RESTANTES, TAPO_PUNTOS, TAPO_DIFERENCIA_GOLES, TAPO_TOTAL_GOLES) AS
(SELECT TOPU_TORNEO, TOPU_EQUIPO, ROW_NUMBER() OVER(PARTITION BY TOPU_TORNEO ORDER BY TOPU_PUNTOS DESC, TOPU_DIFERENCIA_GOLES DESC, TOPU_TOTAL_GOLES DESC) AS TOPO_POSICION, TOPU_PARTIDOS, TOPU_FECHAS_RESTANTES, TOPU_PUNTOS, TOPU_DIFERENCIA_GOLES, TOPU_TOTAL_GOLES
FROM TORNEO_PUNTOS)