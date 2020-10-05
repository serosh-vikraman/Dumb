 
ALTER PROCEDURE [dbo].[GetAllProjectForScenario] @P_ScenarioID int
	 
AS
BEGIN	


SELECT max(p.[ProjectName]) ProjectName
      ,max(p.[ManualProjectCode])  ManualProjectCode
	  ,max(p.IFSProjectCode) ProjectCode
	  ,'Manual' ProjectType
	 
  FROM [dbo].[Project] p 
  left join ScenarioProjectMapper spm on p.ProjectID = spm.ProjectID
  where (ProjectType='Manual' and ProjectStatus = 'Active') and spm.ScenarioID <> @P_ScenarioID  Group By p.ProjectID

UNION 
SELECT m.[project_short_title] 
      ,'' As ProjectCode
      ,m.[project_code]	
	  ,'Referential' 
	 
  FROM [dbo].[MEREF_VW_Project] m
  where (project_end_date > CURRENT_TIMESTAMP)
  and m.[project_code]	 not in (Select IFSProjectCode from Project p inner join ScenarioProjectMapper spm on p.ProjectID = spm.ProjectID
  where spm.ScenarioID = @P_ScenarioID )
  
	;
END
