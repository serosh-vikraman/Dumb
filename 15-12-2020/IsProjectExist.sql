
ALTER PROCEDURE [dbo].[IsProjectExist] @P_ProjectName Varchar(500)
	
AS
BEGIN
SELECT COUNT(1) FROM Project where trim(ProjectName)=@P_ProjectName;
END
