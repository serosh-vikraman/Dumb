 
ALTER PROCEDURE [dbo].[LinkProject] @P_Id int,@P_IFSProjectCode varchar(20),@P_CreatedBy varchar(50)

	
AS
BEGIN

Declare @V_ProjectName varchar(200);



Select @V_ProjectName = project_short_title from meref_temp_projects where project_code = @P_IFSProjectCode;

UPDATE [dbo].[Project]
   SET [ProjectType] = 'Referential'
      ,[IFSProjectCode] = @P_IFSProjectCode
	  ,[ProjectName]=@V_ProjectName
      ,[UpdatedBy] = @P_CreatedBy
      ,[UpdatedAt] = getdate()
 WHERE ProjectID = @P_Id; 

 
 Select @P_Id;
 
END 