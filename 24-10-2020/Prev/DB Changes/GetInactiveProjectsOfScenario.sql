
CREATE PROCEDURE [dbo].[GetInactiveProjectsOfScenario] @P_ScenarioId int
	 
AS
BEGIN

SELECT count(p.ProjectID)
		--p.ProjectID ProjectId
  --    ,p.ProjectType
  --    ,case p.ProjectType When 'Manual' THEN p.ManualProjectCode ELSE p.IFSProjectCode end as ProjectCode
  --    ,p.ProjectName
	 -- ,p.ProjectStatus
      
  FROM [dbo].[Project] p LEFT JOIN ScenarioProjectMapper spm on p.ProjectID = spm.ProjectID
  WHERE (spm.ScenarioID = @P_ScenarioId and p.ProjectStatus = 'Inactive');

END
