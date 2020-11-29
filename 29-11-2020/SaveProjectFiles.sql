 

CREATE Procedure [dbo].[SaveProjectFiles] @P_UploadSessionId VARCHAR(300), 
@P_FileName VARCHAR(100),@P_FilePath varchar(250),@P_CreatedBy VARCHAR(50)
AS
Declare @V_Id int;
BEGIN
INSERT INTO [dbo].ProjectUploadFiles
           ([SessionId]
           ,[FileName]
		   ,FilePath
           ,[CreatedAt]
           ,[CreatedBy]
           ,[Status]
		   ,[Message])
     VALUES
           (@P_UploadSessionId
		   ,@P_FileName
           ,@P_FilePath
           ,GETDATE()
           ,@P_CreatedBy
           ,'Created'
		   ,'');

		    Select @V_Id = @@IDENTITY;

		   Exec LogActivity 'SaveProjectFiles','Save',@V_Id,'Save',@P_CreatedBy;

END;
GO


