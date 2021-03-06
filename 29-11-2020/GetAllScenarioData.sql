
ALTER PROCEDURE [dbo].[GetAllScenarioData] @P_ProjectId INT, @P_ScenarioId INT
	
AS
BEGIN
DECLARE @V_ScenarioScopeCode VARCHAR(5);
DECLARE @V_ScenarioTypeCode VARCHAR(5);

SET @V_ScenarioScopeCode=(SELECT ScenarioScopeCode FROM Scenario WHERE ScenarioID =@P_ScenarioId);
SET @V_ScenarioTypeCode=(SELECT ScenarioTypeCode FROM Scenario WHERE ScenarioID =@P_ScenarioId);

SELECT Distinct value FROM ScenarioApplicableYears  unpivot(value for FinancialYear in ([Year1],[Year2],[Year3],[Year4],[Year5])) p where p.ScenarioId=@P_ScenarioId;

SELECT [Year],[Lock] FROM LockYear 
WHERE [Year] IN (SELECT Distinct value FROM ScenarioApplicableYears  unpivot(value for FinancialYear in ([Year1],[Year2],[Year3],[Year4],[Year5])) p where p.ScenarioId=@P_ScenarioId);

SELECT [Year],[Quarter],[Lock] FROM LockQuarter 
WHERE [Year] 
IN (SELECT Distinct value FROM ScenarioApplicableYears  unpivot(value for FinancialYear in ([Year1],[Year2],[Year3],[Year4],[Year5])) p where p.ScenarioId=@P_ScenarioId);

SELECT DISTINCT SD.[Id]
      ,SD.[ScenarioID] ScenarioId
      ,SD.[ProjectID] ProjectId
      ,SD.[ScenarioDataTypeID] ScenarioDataTypeId
      ,SD.[Year] 
      ,SD.[Q1New]
      ,SD.[Q1Variant]
      ,SD.[Q2New]
      ,SD.[Q2Variant]
      ,SD.[Q3New]
      ,SD.[Q3Variant]
      ,SD.[Q4New]
      ,SD.[Q4Variant]
	  ,FTM.[FinancialDataTypeName] ScenarioDataType
	  
  FROM [dbo].[ScenarioData] SD
  
  inner JOIN FinancialDataTypesScenario FT ON FT.ScenarioDataTypeID = SD.ScenarioDataTypeID
  inner JOIN FinancialDataTypeMaster FTM ON(FT.FinancialDataTypeID=FTM.FinancialDataTypeID)
  WHERE SD.ScenarioID=@P_ScenarioId AND SD.ProjectID=@P_ProjectId;

  SELECT Comments FROM ScenarioProjectMapper WHERE ScenarioID=@P_ScenarioId and ProjectID = @P_ProjectId;

END