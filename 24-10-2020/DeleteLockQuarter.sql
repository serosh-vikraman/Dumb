
ALTER PROCEDURE [dbo].[DeleteLockQuarter] @P_Id int, @P_User varchar(100)
	
AS
BEGIN

DECLARE @V_Lock bit ;

SELECT @V_Lock = Lock FROM LOCKQUARTER WHERE Id = @P_Id;

IF (@V_Lock = 0)
BEGIN
Delete from LockQuarter
  
 WHERE Id = @P_Id;
  Exec LogActivity 'LockQuarter','DELETE',@P_Id,'',@P_User;
 Select @P_Id;
END
END

