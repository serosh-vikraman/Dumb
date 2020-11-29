 
CREATE PROCEDURE [dbo].[IsProjectExist] @P_ProjectName Varchar(50)
	
AS
BEGIN
SELECT COUNT(1) FROM Project where ProjectName=@P_ProjectName;
END

GO


