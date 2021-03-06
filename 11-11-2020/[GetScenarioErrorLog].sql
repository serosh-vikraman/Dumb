
ALTER PROCEDURE [dbo].[GetScenarioErrorLog] @P_SessionId varchar(100)
,@P_Type int
	 
AS
BEGIN
if(@P_Type=1)
begin
SELECT isnull([ScenarioID],0)[ScenarioID]
				,isnull([UploadSessionID],'')[UploadSessionID]
				,isnull([ProjectCode],'') [ProjectCode]
				,isnull([RowNumber],0)[RowNumber]
				,isnull([UploadDescription],'')[UploadDescription]
				,isnull([CreatedBy],'')[CreatedBy]
				,isnull([CreatedAt],'')[CreatedAt],
				[UploadStatus]
      ,'' ErrorCode
      ,[ColumnNumber] [ColumnNumber]
  FROM [dbo].[ScenarioUploadLog] 
  where [UploadSessionID]=@P_SessionId
  end
  else
begin
  SELECT isnull([ScenarioID],0)[ScenarioID]
				,isnull([UploadSessionID],'')[UploadSessionID]
				,isnull([ProjectCode],'') [ProjectCode]
				,isnull([RowNumber],0)[RowNumber]
				,isnull([UploadDescription],'')[UploadDescription]
				,isnull([CreatedBy],'')[CreatedBy]
				,isnull([CreatedAt],'')[CreatedAt],
				[UploadStatus]
      ,'' ErrorCode
      ,[ColumnNumber] [ColumnNumber]
  FROM [dbo].[ScenarioUploadLog] 
  where [UploadSessionID]=@P_SessionId and UploadStatus=0
  end
END
