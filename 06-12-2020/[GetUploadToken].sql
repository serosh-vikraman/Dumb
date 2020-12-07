 
create PROCEDURE [dbo].[GetUploadToken] (@P_SessionId varchar(100),@P_UserId VARCHAR(100), @P_SecondTime INT)
AS
BEGIN


DECLARE @ReturnGUid VARCHAR(500);

DECLARE @DocumentCreatedOn DATETIME;
DECLARE @DocumentCount INT;
DECLARE @Datediff INT;
DECLARE @DocumentFileName VARCHAR(500);

SELECT @DocumentCount = COUNT(1)
FROM [TempuploadFile]
WHERE  [UploadSessionId] =@P_SessionId
AND UserId = @P_UserId;

IF (@DocumentCount = 0)
BEGIN
    SET @ReturnGUid =CAST( NEWID() AS nvarchar(100));
SELECT @DocumentFileName = [ScenarioFileName] 
FROM [dbo].[ScenarioFiles]
WHERE [UploadSessionId] =@P_SessionId;

INSERT INTO [TempuploadFile] ([UploadSessionId], UserId, Token, CreatedOn, FileName)
VALUES (@P_SessionId, @P_UserId,@ReturnGUid, GETDATE(), @DocumentFileName);
END;
ELSE
BEGIN
SELECT @DocumentCreatedOn = CreatedOn,@ReturnGUid = Token
FROM [TempuploadFile]
WHERE [UploadSessionId] =@P_SessionId
AND UserId = @P_UserId;

SELECT @Datediff = DATEDIFF(MINUTE,  @DocumentCreatedOn, GETDATE())

IF (@Datediff > 10)
SET @ReturnGUid = '';

IF (@P_SecondTime = 1)
        BEGIN
        SET @ReturnGUid =CAST( NEWID() AS nvarchar(100));
UPDATE [TempuploadFile]
SET CreatedOn = GETDATE(),
            Token=@ReturnGUid
WHERE [UploadSessionId] =@P_SessionId
AND UserId = @P_UserId;
                END;
END;

SELECT @ReturnGUid;
END;
