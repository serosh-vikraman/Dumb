
ALTER PROCEDURE [dbo].[GetAllQuarterlyDataOfScenario] @P_ScenarioId INT
	
AS
BEGIN

SELECT DISTINCT SD.[Id]
      ,SD.[ScenarioID] ScenarioId
      ,SD.[ProjectID] ProjectId
	  ,P.ProjectName
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
  inner JOIN Project P ON (P.ProjectId = SD.ProjectID)
  WHERE SD.ScenarioID=@P_ScenarioId ;
END