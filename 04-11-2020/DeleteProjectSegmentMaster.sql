

ALTER PROCEDURE [dbo].[DeleteProjectSegmentMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_ProjectSegmentName varchar(100);

SELECT @V_ProjectSegmentName = ProjectSegmentName FROM [ProjectSegmentMaster] WHERE ProjectSegmentID = @P_Id;

DELETE FROM [dbo].[ProjectSegmentMaster]
      WHERE ProjectSegmentID=@P_Id;

 Exec LogActivity 'ProjectSegmentMaster','DELETE',@P_Id,@V_ProjectSegmentName,@P_User;
 Select @P_Id;

END


