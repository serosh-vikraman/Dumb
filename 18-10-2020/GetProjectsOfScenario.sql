USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[GetProjectsOfScenario]    Script Date: 14-10-2020 04:42:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
