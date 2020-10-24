
-- exec GetScenarioErrorLog '0D91DF28-0DAD-419A-9E31-BF739294F937'
ALTER PROCEDURE [dbo].[GetScenarioErrorLog] @P_SessionId varchar(100)
	 
AS
BEGIN

SELECT [ScenarioID]
				,[UploadSessionID]
				,[ProjectCode]
				,[RowNumber]
				,[UploadDescription]
				,[CreatedBy]
				,[CreatedAt]
      ,'' ErrorCode
      ,0 ColumnNumber
  FROM [dbo].[ScenarioUploadLog] 
  where [UploadSessionID]=@P_SessionId

END
