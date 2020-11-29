 
CREATE PROCEDURE [dbo].[GetScenarioByYear] @P_Year int
	
AS
BEGIN
	
SELECT
S.[ScenarioID]
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
   
  where (S.[FinancialYear]=@P_Year) ORDER BY ScenarioName ASC ;

END
GO


