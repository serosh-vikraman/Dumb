
ALTER Procedure [dbo].[SaveScenarioFiles] @P_UploadSessionId VARCHAR(300),@P_ScenarioId INT,
@P_ScenarioFileName VARCHAR(100),@P_FilePath varchar(250),@P_TypeId INT,@P_CreatedBy VARCHAR(50),@P_Year int,@P_Quarter varchar(15)
AS
Declare @V_Id int;
BEGIN
INSERT INTO [dbo].[ScenarioFiles]
           ([UploadSessionId]
           ,[ScenarioFileName]
		   ,FilePath
           ,[CreatedAt]
           ,[CreatedBy]
           ,[ScenarioId]
		   ,[TypeId]
		   ,[Year]
		   ,[Quarter])
     VALUES
           (@P_UploadSessionId
           ,@P_ScenarioFileName
		   ,@P_FilePath
           ,GETDATE()
           ,@P_CreatedBy
           ,@P_ScenarioId
		   ,@P_TypeId
		   ,@P_Year
		   ,@P_Quarter);

		    Select @V_Id = @@IDENTITY;

		   Exec LogActivity 'ScenarioFiles','Save',@V_Id,'Save',@P_CreatedBy;

END;
