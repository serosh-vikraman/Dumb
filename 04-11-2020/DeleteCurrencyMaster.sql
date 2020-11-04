

ALTER PROCEDURE [dbo].[DeleteCurrencyMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_CurrencyName varchar(100);

SELECT @V_CurrencyName = CurrencyName FROM [CurrencyMaster] WHERE CurrencyID = @P_Id;

DELETE FROM CurrencyMaster
      WHERE CurrencyID=@P_Id;
 Exec LogActivity 'CurrencyMaster','DELETE',@P_Id,@V_CurrencyName,@P_User;
 Select @P_Id;

END

