
ALTER PROCEDURE [dbo].[DeleteBillingTypesMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_BillingTypeName varchar(100);
SELECT @V_BillingTypeName = BillingTypeName FROM BillingTypesMaster WHERE BillingTypeID = @P_Id;
DELETE FROM [dbo].[BillingTypesMaster]
      WHERE BillingTypeID=@P_Id;

 EXEC LogActivity 'BillingTypesMaster','DELETE',@P_Id,@V_BillingTypeName,@P_User;
 SELECT @P_Id;

END

