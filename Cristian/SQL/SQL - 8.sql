-- ---------------------------------------------------------------------------------------------------------------------------
 /* 8) Mostrar DNI, APELLIDO, NOMBRES, EQUIPOS y DIVISIONES de los jugadores que se han lesionado y tienen un tiempo de
recuperación mayor a 1 semana */
-- ---------------------------------------------------------------------------------------------------------------------------
SELECT
J.JUGA_DNI 'DNI',
J.JUGA_APELLIDO 'APELLIDO',
J.JUGA_NOMBRES 'NOMBRE',
E.EQUI_NOMBRE 'EQUIPO',
E.EQUI_DIVISION 'DIVISION'

FROM LESION_JUGADOR LJ
		 INNER JOIN JUGADOR J ON J.JUGA_DNI = LJ.LEJU_JUGADOR
		 INNER JOIN TIPO_LESION TL ON TL.TILE_CODIGO = LJ.LEJU_LESION
		 INNER JOIN PARTIDO P ON P.PART_CODIGO = LJ.LEJU_PARTIDO
		 INNER JOIN EQUIPO E ON (E.EQUI_CODIGO = P.PART_LOCAL OR E.EQUI_CODIGO = P.PART_VISITANTE)
		 
WHERE TL.TILE_DIAS_RECUPERACION > 7