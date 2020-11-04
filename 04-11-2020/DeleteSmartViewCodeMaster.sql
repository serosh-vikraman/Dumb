
ALTER PROCEDURE [dbo].[DeleteSmartViewCodeMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_SmartViewCodeName varchar(100);

SELECT @V_SmartViewCodeName = SmartViewName FROM [SmartViewCodeMaster] WHERE SmartViewCodeID = @P_Id;
DELETE FROM [dbo].[SmartViewCodeMaster]
      WHERE SmartViewCodeID=@P_Id;

 Exec LogActivity 'SmartViewCodeMaster','DELETE',@P_Id,@V_SmartViewCodeName,@P_User;
 Select @P_Id;

END

