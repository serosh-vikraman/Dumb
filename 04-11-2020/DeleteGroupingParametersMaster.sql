
ALTER PROCEDURE [dbo].[DeleteGroupingParametersMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_GroupingParametersName varchar(100);

SELECT @V_GroupingParametersName = GroupingParametersName FROM [GroupingParametersMaster] WHERE GroupingParametersID = @P_Id;
DELETE FROM [dbo].[GroupingParametersMaster]
      WHERE GroupingParametersID=@P_Id;

 Exec LogActivity 'GroupingParametersMaster','DELETE',@P_Id,@V_GroupingParametersName,@P_User;
 Select @P_Id;

END

