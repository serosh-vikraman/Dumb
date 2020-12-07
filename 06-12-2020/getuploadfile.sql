
create PROCEDURE [dbo].GetUploadFile (@P_GUId VARCHAR(100))
AS
BEGIN
	DECLARE @DocumentCreatedOn DATETIME;
	DECLARE @P_DocumentId INT;
	DECLARE @Datediff INT;
	DECLARE @DocumentFileName VARCHAR(500);
	DECLARE @DocumentFilePath VARCHAR(500);

	SELECT @DocumentCreatedOn = CreatedOn, @P_DocumentId = [UploadSessionId]
	FROM [TempuploadFile]
	WHERE Token = @P_GUId;

	SELECT @Datediff = DATEDIFF(MINUTE, @DocumentCreatedOn, GETDATE())
 

	IF (@Datediff > 10)
		SELECT '' as [UploadSessionId],  @DocumentFilePath as DocumentFilePath, @DocumentFileName as DocumentName;
        ELSE
        SELECT  [UploadSessionId],'' as DocumentFilePath, [ScenarioFileName]
	FROM [dbo].[ScenarioFiles]
	WHERE [UploadSessionId] = @P_DocumentId;
END;