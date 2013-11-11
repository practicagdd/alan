CREATE FUNCTION ENTRETIEMPO (@COD_PART INT) RETURNS INT AS
BEGIN
 DECLARE @ENTRETIEMPO INT
 SET @ENTRETIEMPO = (SELECT (P.PART_DURACION - P.PART_ADICIONAL - 40) FROM PARTIDO P WHERE P.PART_CODIGO = @COD_PART)
 RETURN @ENTRETIEMPO
 END