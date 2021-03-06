
ALTER PROCEDURE [dbo].[DeleteBUCategoryMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_BUCategoryName varchar(100);

SELECT @V_BUCategoryName = BUCategoryName FROM BUCategoryMaster WHERE BUCategoryID = @P_Id;

DELETE FROM [dbo].[BUCategoryMaster]
      WHERE BUCategoryID=@P_Id;

 Exec LogActivity 'BUCategoryMaster','DELETE',@P_Id,@V_BUCategoryName,@P_User;
 Select @P_Id;

END

