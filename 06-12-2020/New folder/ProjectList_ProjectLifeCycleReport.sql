 
ALTER  PROCEDURE [dbo].[ProjectList_ProjectLifeCycleReport]
 AS
BEGIN

--   exec [ProjectLifeCycleReport] 280, 2020,'PL'

SELECT DISTINCT A.ProjectId, CASE WHEN ISNULL(IFSProjectCode,'X')<>'X' THEN CONCAT(IFSProjectCode, ' - ', ProjectName)
     
    ELSE CONCAT(ManualProjectCode, ' - ', ProjectName)  END ProjectName   from Project A
	inner join ScenarioProjectMapper B on(A.ProjectId=B.ProjectId);

	END;