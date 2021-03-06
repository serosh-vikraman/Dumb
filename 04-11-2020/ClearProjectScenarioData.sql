
ALTER PROCEDURE [dbo].[ClearProjectScenarioData] @P_ScenarioId int, @P_ProjectId int,@P_User Varchar(50)
	
AS
BEGIN

Declare @V_LogDescription varchar(2000) ;
DECLARE @V_Lock BIT;
DECLARE @V_ScenarioName varchar(100);
DECLARE @V_ProjectName varchar(250);
SET @V_Lock = (
					SELECT ScenarioLock
					FROM Scenario
					WHERE ScenarioID = @P_ScenarioId
					);
IF @V_Lock = 0
BEGIN
	DELETE FROM [dbo].ScenarioData
      WHERE ScenarioID = @P_ScenarioId AND ProjectID = @P_ProjectId;

	  SELECT @V_ScenarioName = ScenarioName FROM Scenario WHERE ScenarioID = @P_ScenarioId; 
	  SELECT @V_ProjectName = ProjectName FROM Project WHERE ProjectID = @P_ProjectId; 

	SET @V_LogDescription = 'Clear data from Project ' + @V_ProjectName +'  of Scenario  '+ CAST( @P_ScenarioId as varchar(10)) + ' ScenarioName =' +@V_ScenarioName;
	Exec LogActivity 'ScenarioData','Clear',@P_ProjectId,@V_LogDescription,@P_User;
	Select @P_ScenarioId;
END;
END

