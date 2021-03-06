
ALTER PROCEDURE [dbo].[DeleteCurrencyExchange] @P_Id int, @P_User varchar(100)
	
AS
BEGIN

DECLARE @V_LockStatus bit;

SELECT @V_LockStatus = LockStatus from CurrencyExchange WHERE Id = 	@P_Id;
 IF (@V_LockStatus = 0)
 BEGIN
DELETE FROM CurrencyExchange
      WHERE Id=@P_Id;
 Exec LogActivity 'CurrencyExchange','DELETE',@P_Id,'',@P_User;
 Select @P_Id;
END;
END

