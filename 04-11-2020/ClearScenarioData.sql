
ALTER PROCEDURE [dbo].[ClearScenarioData] @P_ScenarioId int,@P_User Varchar(50)
	
AS
BEGIN
DECLARE @V_Lock BIT;
DECLARE @V_ScenarioName varchar(100);

SET @V_Lock = (
					SELECT ScenarioLock
					FROM Scenario
					WHERE ScenarioID = @P_ScenarioId
					);
IF @V_Lock = 0
BEGIN
DELETE FROM [dbo].ScenarioData
      WHERE ScenarioID = @P_ScenarioId;

	  SELECT @V_ScenarioName = ScenarioName FROM Scenario WHERE ScenarioID = @P_ScenarioId; 
	  
	  Exec LogActivity 'ScenarioData','ClearScenarioData',@P_ScenarioId,@V_ScenarioName,@P_User;
 Select @P_ScenarioId;
END
END

