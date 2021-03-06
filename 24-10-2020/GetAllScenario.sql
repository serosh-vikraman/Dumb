
ALTER PROCEDURE [dbo].[GetAllScenario] @P_Id int
	
AS
BEGIN
	

SELECT S.[ScenarioID]
      ,S.[ScenarioScopeCode]
      ,S.[ScenarioTypeCode]
      ,S.[FinancialYear]
      ,S.[ScenarioSequenceNumber]
      ,S.[ScenarioName]
      ,S.[Description]
      ,S.[ScenarioLock]
      ,S.[CreatedBy]
	  ,Case S.ScenarioLock When 0 then 'Active' else 'Inactive' End Status
	  ,SSM.ScenarioScopeName
	  ,STM.ScenarioTypeName
     
  FROM [dbo].[Scenario] S
  LEFT JOIN ScenarioScopeMaster SSM ON S.ScenarioScopeCode = SSM.ScenarioScopeCode
  LEFT JOIN ScenarioTypeMaster STM ON S.ScenarioTypeCode = STM.ScenarioTypeCode
  where (ScenarioID=@P_Id or @P_Id=0) ORDER BY ScenarioName ASC ;

END
