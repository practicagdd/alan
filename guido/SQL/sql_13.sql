SELECT a.ARBI_DNI as DNI_PERSONA, a.ARBI_DNI AS NOMBRE, a.ARBI_DNI AS APELLIDO, 
(select COUNT(*) from JUGADOR_PARTIDO jp 
where jp.JUPA_TITULAR='S' and jp.JUPA_JUGADOR=a.ARBI_DNI) as cantTitular, 
	
(select COUNT(*) from PARTIDO p 
where (p.PART_CALIF_ARBITRO=1 OR p.PART_CALIF_ARBITRO=2) 
and p.PART_ARBITRO= a.ARBI_DNI) as cantBuenasCalif,

(select COUNT(*) from PARTIDO p 
join JUGADOR_PARTIDO jp on jp.JUPA_PARTIDO = p.PART_CODIGO
join EQUIPO e on (e.EQUI_CODIGO = p.PART_LOCAL OR e.EQUI_CODIGO = p.PART_VISITANTE)	
where JP.JUPA_JUGADOR=a.ARBI_DNI AND e.EQUI_DT=a.ARBI_DNI) as cantTecnicoyJugador

FROM ARBITRO a
WHERE	a.ARBI_DNI in (SELECT J.JUGA_DNI FROM JUGADOR j)
		AND a.ARBI_DNI IN (SELECT DT.DITE_DNI FROM DIRECTOR_TECNICO DT)
order by a.ARBI_REPUTACION desc