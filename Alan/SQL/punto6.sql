select (j.JUGA_APELLIDO + ', ' + j.JUGA_NOMBRES) Jugador, COUNT(t.TIAC_DETALLE) 'Cantidad de goles'
from JUGADOR j
left join DETALLE_PARTIDO d ON d.DEPA_JUGADOR = j.JUGA_DNI 
left join TIPO_ACCION t on  d.DEPA_ACCION = t.TIAC_CODIGO AND t.TIAC_DETALLE = 'GOL'
group by (j.JUGA_APELLIDO + ', ' + j.JUGA_NOMBRES)
order by COUNT(t.TIAC_DETALLE) desc