/* 4) Realizar un control que no permita dar de alta mas de un torneo por división */
-- ---------------------------------------------------------------------------------------
CREATE TRIGGER CONTROL_TORNEO_X_DIVISION 
ON TORNEO
FOR INSERT,UPDATE
AS
BEGIN

DECLARE @DIVISION CHAR(1)
DECLARE @CANT INT
SET @CANT = 0

DECLARE C1 CURSOR
FOR SELECT TORN_DIVISION FROM inserted 

OPEN C1
FETCH C1 INTO @DIVISION
WHILE (@@FETCH_STATUS=0)
	BEGIN
		(SELECT @CANT = COUNT(*)
		FROM TORNEO T
		WHERE T.TORN_DIVISION = @DIVISION)
		IF @CANT > 1
			BEGIN	
				ROLLBACK TRANSACTION
				RETURN
			END
		
		FETCH C1 INTO @DIVISION
	END
	
	CLOSE C1
	DEALLOCATE C1

END
-- ---------------------------------------------------------------------------------------
