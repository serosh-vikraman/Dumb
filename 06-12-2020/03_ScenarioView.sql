
Create View [dbo].[ScenarioView]
AS

SELECT Max(ScenarioId) ScenarioId, FinancialYear, ScenarioScopeCode, ScenarioTypeCode, MAX(ScenarioName) ScenarioName

from Scenario GROUP BY FinancialYear, ScenarioScopeCode, ScenarioTypeCode
GO


