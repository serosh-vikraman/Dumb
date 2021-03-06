USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[GetInactiveProjectsOfScenario]    Script Date: 17-10-2020 10:34:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
