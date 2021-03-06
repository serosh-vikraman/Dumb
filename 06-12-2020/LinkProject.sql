 
ALTER PROCEDURE [dbo].[LinkProject] @P_Id int,@P_IFSProjectCode varchar(20),@P_CreatedBy varchar(50)

	
AS
BEGIN

DECLARE @V_ProjectName varchar(200);

SELECT @V_ProjectName = project_short_title FROM [MEREF_VW_Project] WHERE project_code = @P_IFSProjectCode;

UPDATE [dbo].[Project]
   SET [ProjectType] = 'Referential'
      ,[IFSProjectCode] = @P_IFSProjectCode
	  ,[ProjectName]=@V_ProjectName
      ,[UpdatedBy] = @P_CreatedBy
      ,[UpdatedAt] = getdate()
 WHERE ProjectID = @P_Id; 

 
 SELECT @P_Id;
 
END 