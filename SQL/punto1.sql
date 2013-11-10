select LEFT(CONVERT(varchar, les.LEJU_FECHA_REAL, 112),6) FECHA, COUNT(*) CuantasLesiones, COUNT(DIStinct les.LEJU_PARTIDO) EnCuantosPartidos
from LESION_JUGADOR les
group by LEFT(CONVERT(varchar, les.LEJU_FECHA_REAL, 112),6)
order by LEFT(CONVERT(varchar, les.LEJU_FECHA_REAL, 112),6)