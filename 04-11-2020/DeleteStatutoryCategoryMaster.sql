
ALTER PROCEDURE [dbo].[DeleteStatutoryCategoryMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_StatutoryCategoryName varchar(100);

SELECT @V_StatutoryCategoryName = StatutoryCategoryName FROM [StatutoryCategoryMaster] WHERE StatutoryCategoryID = @P_Id;
DELETE FROM [dbo].[StatutoryCategoryMaster]
      WHERE StatutoryCategoryID=@P_Id;

 Exec LogActivity 'StatutoryCategoryMaster','DELETE',@P_Id,@V_StatutoryCategoryName,@P_User;
 Select @P_Id;

END

