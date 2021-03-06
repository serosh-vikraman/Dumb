
ALTER PROCEDURE [dbo].[DeLinkProject] @P_Id int,@P_ProjectName varchar(200),@P_CreatedBy varchar(50)

	
AS
BEGIN
DECLARE @V_IFSProjectCode varchar(20);
SELECT @V_IFSProjectCode = IFSProjectCode FROM Project WHERE ProjectID = @P_Id;

UPDATE [dbo].[Project]
   SET [ProjectType] = 'Manual'
	  ,[ProjectName]= @P_ProjectName
      ,[IFSProjectCode] = null
      ,[UpdatedBy] = @P_CreatedBy
      ,[UpdatedAt] = getdate()
 WHERE ProjectID = @P_Id; 

  Exec LogActivity 'DeLinkProject','UPDATE',@P_Id,@V_IFSProjectCode,@P_CreatedBy;
 Select @P_Id;
 
END
