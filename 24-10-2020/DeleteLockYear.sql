
ALTER PROCEDURE [dbo].[DeleteLockYear] @P_Year int,@P_User varchar(50)
	
AS
BEGIN
DECLARE @V_Lock bit;

SELECT @V_Lock = Lock FROM LockYear WHERE [Year] = @P_Year;

IF (@V_Lock = 0)

BEGIN

DELETE FROM LockYear
  
 WHERE [Year] = @P_Year;
 EXEC LogActivity 'LockYear','DELETE',@P_Year,'',@P_User;
 SELECT @P_Year;

END;
END