
ALTER PROCEDURE [dbo].[GetAllProjectForScenario] 
@P_ScenarioId int	 
AS
BEGIN		
SELECT [ProjectName] ProjectName
      ,[ManualProjectCode]  ManualProjectCode
	  ,IFSProjectCode ProjectCode
	  ,'Manual' ProjectType
	 
  FROM [dbo].[Project]  where (ProjectType='Manual' and ProjectStatus = 'Active')

UNION 
SELECT [project_short_title] ProjectName
      ,'' As ManualProjectCode
      ,[project_code]	ProjectCode
	  ,'Referential' ProjectType
	 
  FROM [dbo].[MEREF_VW_Project] where (project_end_date > CURRENT_TIMESTAMP)
	;
END


ALTER PROCEDURE [dbo].GetWIPStatus @P_ScenarioId int,@P_ProjectId int 
	
AS
BEGIN
 
  Select TOP 1 ScenarioProjectLogId, ScenarioId, ProjectId, [Status] from ScenarioProjectLog where ScenarioId = @P_ScenarioId 

  order by Createdat DESC;

 
END