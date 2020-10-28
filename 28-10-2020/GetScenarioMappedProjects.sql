ALTER Procedure [dbo].[GetScenarioMappedProjects] @P_ScenarioId INT
AS BEGIN

Select P.ProjectId ProjectId,Isnull(P.IFSProjectCode,'') ProjectCode,
ISNULL(P.ManualProjectCode,'') ManualProjectCode From ScenarioProjectMapper SP 
INNER JOIN Project P ON p.ProjectID = SP.ProjectID
WHERE SP.ScenarioID=@P_ScenarioId ;


END;