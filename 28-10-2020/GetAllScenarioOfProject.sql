
ALTER PROCEDURE [dbo].[GetAllScenarioOfProject] @P_ProjectId int
	
AS
BEGIN
	
	
SELECT s.ScenarioID
      ,s.ScenarioScopeCode
      ,s.ScenarioTypeCode
      ,s.FinancialYear
      ,s.ScenarioSequenceNumber
      ,s.ScenarioName
      ,s.[Description]
      ,s.ScenarioLock 
	  ,spm.ProjectID
      ,Case s.ScenarioLock When 0 then 'Active' else 'InActive' End Status 
	  ,SSM.ScenarioScopeName
	  ,STM.ScenarioTypeName
  FROM [dbo].[Scenario] s  left join ScenarioProjectMapper spm on s.ScenarioID = spm.ScenarioID
  LEFT JOIN ScenarioScopeMaster SSM ON s.ScenarioScopeCode = SSM.ScenarioScopeCode
  LEFT JOIN ScenarioTypeMaster STM ON s.ScenarioTypeCode = STM.ScenarioTypeCode
  where spm.ProjectID=@P_ProjectId ;

END
