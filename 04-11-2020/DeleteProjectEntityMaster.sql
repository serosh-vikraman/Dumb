
ALTER PROCEDURE [dbo].[DeleteProjectEntityMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_ProjectEntityName varchar(100);

SELECT @V_ProjectEntityName = ProjectEntityName FROM [ProjectEntityMaster] WHERE ProjectEntityID = @P_Id;
DELETE FROM [dbo].[ProjectEntityMaster]
      WHERE ProjectEntityID=@P_Id;

 Exec LogActivity 'ProjectEntityMaster','DELETE',@P_Id,@V_ProjectEntityName,@P_User;
 Select @P_Id;

END

