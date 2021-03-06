
ALTER PROCEDURE [dbo].[GetAllQuarterlyDataOfScenario] @P_ScenarioId INT
	
AS
BEGIN

SELECT DISTINCT SD.[Id]
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
  inner JOIN Project P ON (P.ProjectId = SD.ProjectID)
  WHERE SD.ScenarioID=@P_ScenarioId ;

SELECT  P.ProjectId,CASE isnull(P.IFSProjectCode, '') WHEN '' THEN P.[ManualProjectCode] ELSE P.IFSProjectCode END as ProjectCode,
        P.ProjectName from Project P inner join ScenarioProjectMapper SPM ON SPM.ProjectID = P.ProjectID WHERE SPM.ScenarioID = @P_ScenarioId;

SELECT FinancialYear,ScenarioScopeCode, ScenarioTypeCode FROM Scenario WHERE ScenarioID =@P_ScenarioId;

END