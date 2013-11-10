CREATE FUNCTION posicionMasVeces(@jugadorDni int)
returns char(3)
begin
	return (SELECT top 1 JUPA_POSICION
	FROM JUGADOR_PARTIDO 
	WHERE JUPA_JUGADOR = @jugadorDni
	GROUP BY JUPA_POSICION
	ORDER BY COUNT(*) DESC)
end