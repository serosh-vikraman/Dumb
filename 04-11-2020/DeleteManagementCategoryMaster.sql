
ALTER PROCEDURE [dbo].[DeleteManagementCategoryMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_ManagementCategoryName varchar(100);

SELECT @V_ManagementCategoryName = ManagementCategoryName FROM [ManagementCategoryMaster] WHERE ManagementCategoryID = @P_Id;
DELETE FROM [dbo].[ManagementCategoryMaster]
      WHERE ManagementCategoryID=@P_Id;

 Exec LogActivity 'ManagementCategoryMaster','DELETE',@P_Id,@V_ManagementCategoryName,@P_User;
 Select @P_Id;

END

