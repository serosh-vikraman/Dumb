
CREATE PROCEDURE [dbo].[DeleteClubbingParameterMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_ClubbingParameterName varchar(100);

SELECT @V_ClubbingParameterName = ClubbingParameterName FROM [ClubbingParameterMaster] WHERE ClubbingParameterID = @P_Id;
DELETE FROM [dbo].[ClubbingParameterMaster]
      WHERE ClubbingParameterID=@P_Id;

 Exec LogActivity 'ClubbingParameterMaster','DELETE',@P_Id,@V_ClubbingParameterName,@P_User;
 Select @P_Id;

END

