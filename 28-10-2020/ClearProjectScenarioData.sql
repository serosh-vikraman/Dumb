
CREATE PROCEDURE [dbo].[ClearProjectScenarioData] @P_ScenarioId int, @P_ProjectId int,@P_User Varchar(50)
	
AS
BEGIN

Declare @V_LogDescription varchar(100) ;


DELETE FROM [dbo].ScenarioData
      WHERE ScenarioID = @P_ScenarioId AND ProjectID = @P_ProjectId;
	  SET @V_LogDescription = 'Removal of Project from Scenario  '+ CAST( @P_ScenarioId as varchar(10)) ;
	  Exec LogActivity 'ScenarioData','Remove project from scenario',@P_ProjectId,@V_LogDescription,@P_User;
 Select @P_ScenarioId;

END

