
CREATE PROCEDURE [dbo].[ClearScenarioData] @P_ScenarioId int,@P_User Varchar(50)
	
AS
BEGIN


DELETE FROM [dbo].ScenarioData
      WHERE ScenarioID = @P_ScenarioId;
	  
	  Exec LogActivity 'ScenarioData','ClearScenarioData',@P_ScenarioId,'',@P_User;
 Select @P_ScenarioId;

END

