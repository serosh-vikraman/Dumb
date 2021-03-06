
ALTER PROCEDURE [dbo].[ClearScenarioData] @P_ScenarioId int,@P_User Varchar(50)
	
AS
BEGIN
DECLARE @V_Lock BIT;
DECLARE @V_WIPStatus BIT;
DECLARE @V_ScenarioName varchar(100);
DECLARE @ScenarioProjectLogId int;
DECLARE @deletesuccess int = 0;

SET @V_Lock = (
					SELECT ScenarioLock
					FROM Scenario
					WHERE ScenarioID = @P_ScenarioId
					);
SELECT @ScenarioProjectLogId = MAX(ScenarioProjectLogId) FROM ScenarioProjectLog WHERE ScenarioId = @P_ScenarioId  and CreatedBy <> @P_User;

SELECT @V_WIPStatus = [Status] from ScenarioProjectLog WHERE ScenarioProjectLogId = @ScenarioProjectLogId;

IF (@V_Lock = 0) and (@V_WIPStatus = 0 or @V_WIPStatus IS NULL)
BEGIN
DELETE FROM [dbo].ScenarioData
      WHERE ScenarioID = @P_ScenarioId;

	  SELECT @V_ScenarioName = ScenarioName FROM Scenario WHERE ScenarioID = @P_ScenarioId; 
	  
	  Exec LogActivity 'ScenarioData','ClearScenarioData',@P_ScenarioId,@V_ScenarioName,@P_User;
 SET  @deletesuccess = @P_ScenarioId;
END
SELECT @deletesuccess;
END

