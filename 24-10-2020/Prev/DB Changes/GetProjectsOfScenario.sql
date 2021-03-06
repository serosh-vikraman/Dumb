
ALTER PROCEDURE [dbo].[GetProjectsOfScenario] @P_ScenarioId int
	 
AS
BEGIN

SELECT p.ProjectID ProjectId
      ,p.ProjectType
      ,case p.ProjectType When 'Manual' then p.ManualProjectCode else p.IFSProjectCode end as ProjectCode
      --,p.ManualProjectCode
      ,p.ProjectName
	  ,p.ProjectStatus
      
  FROM [dbo].[Project] p left join ScenarioProjectMapper spm on p.ProjectID = spm.ProjectID
  where (spm.ScenarioID = @P_ScenarioId);

END
