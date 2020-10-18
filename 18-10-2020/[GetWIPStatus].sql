 
  

ALTER PROCEDURE [dbo].[GetWIPStatus] @P_ScenarioId int, @P_ProjectId int

AS
BEGIN
DECLARE @DifferenceinSeconds int;
DECLARE @Count int;
DECLARE @LastUpdatedTime int;
DECLARE @ScenarioProjectLogId int;


SELECT
@Count = COUNT(1)
FROM ScenarioProjectLog
WHERE ScenarioId = @P_ScenarioId;

IF (@Count > 0)
BEGIN

		SELECT
		  MAX(ScenarioProjectLogId)
		FROM ScenarioProjectLog
		WHERE ScenarioId = 18;

		 SELECT
      @DifferenceinSeconds = DATEDIFF(SECOND, MAX(CreatedAT), GETDATE())
    FROM ScenarioProjectLog
    WHERE ScenarioId = @P_ScenarioId and ScenarioProjectLogId=@ScenarioProjectLogId;

		IF (@DifferenceinSeconds > 20)
		BEGIN
				INSERT INTO ScenarioProjectLog (ScenarioId, ProjectId, CreatedBy, CreatedAt, [Status])
				SELECT TOP 1
				ScenarioId,
				ProjectId,
				'Admin',
				GETDATE(),
				0
				FROM ScenarioProjectLog
				WHERE ScenarioId = @P_ScenarioId
				ORDER BY 1 DESC;

				SELECT TOP 1
				ScenarioProjectLogId,
				ScenarioId,
				ProjectId,
				[Status] 
				FROM ScenarioProjectLog
				WHERE ScenarioId = @P_ScenarioId
				ORDER BY 1 DESC;
		END
		ELSE
 
				SELECT TOP 1
				ScenarioProjectLogId,
				ScenarioId,
				ProjectId,
				1 as [Status]
				FROM ScenarioProjectLog
				WHERE ScenarioId = @P_ScenarioId  ORDER BY 1 DESC;


		END

END