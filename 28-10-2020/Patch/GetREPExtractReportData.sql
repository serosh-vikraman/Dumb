
CREATE Procedure [dbo].[GetREPExtractReportData] @P_Year INT, @P_ReportTypeId INT, @P_ScenarioId INT
AS
BEGIN
DECLARE @V_ForeCastScenarioTypeCode VARCHAR(5);
DECLARE @V_ActualsScenarioTypeCode VARCHAR(5);
DECLARE @V_ScenarioScopeCode VARCHAR(5); 
DECLARE @V_AC_RVID INT;
DECLARE @V_AC_GMID INT;
DECLARE @V_FC_RVID INT;
DECLARE @V_FC_GMID INT;

SET @V_ScenarioScopeCode = (SELECT ScenarioScopeCode FROM ScenarioScopeMaster WHERE ScenarioScopeID = 3);
SET @V_ActualsScenarioTypeCode = (SELECT ScenarioTypeCode FROM ScenarioTypeMaster WHERE ScenarioTypeID = 3);
SET @V_ForeCastScenarioTypeCode = (SELECT ScenarioTypeCode FROM ScenarioTypeMaster WHERE ScenarioTypeID = 5);


SET @V_AC_RVID =(SELECT ScenarioDataTypeID FROM FinancialDataTypesScenario WHERE ScenarioScopeCode = @V_ScenarioScopeCode AND ScenarioTypeCode = @V_ActualsScenarioTypeCode AND FinancialDataTypeID=1);
SET @V_AC_GMID =(SELECT ScenarioDataTypeID FROM FinancialDataTypesScenario WHERE ScenarioScopeCode = @V_ScenarioScopeCode AND ScenarioTypeCode = @V_ActualsScenarioTypeCode AND FinancialDataTypeID=2);

SET @V_FC_RVID =(SELECT ScenarioDataTypeID FROM FinancialDataTypesScenario WHERE ScenarioScopeCode = @V_ScenarioScopeCode AND ScenarioTypeCode = @V_ForeCastScenarioTypeCode AND FinancialDataTypeID=1);
SET @V_FC_GMID =(SELECT ScenarioDataTypeID FROM FinancialDataTypesScenario WHERE ScenarioScopeCode = @V_ScenarioScopeCode AND ScenarioTypeCode = @V_ForeCastScenarioTypeCode AND FinancialDataTypeID=2);

IF @P_ReportTypeId = 1 
BEGIN
SELECT DISTINCT PE.ProjectEntityCode,PE.ProjectEntityName,SM.SmartViewCode,SM.SmartViewName,
BU.BUCategoryCode,BU.BUCategoryName,PS.ProjectSegmentCode,PS.ProjectSegmentName,SD.ScenarioDataTypeID,SUM(SD.Q1New) Q1New,SUM(SD.Q2New) Q2New,SUM(SD.Q3New) Q3New,SUM(SD.Q4New) Q4New
FROM Project P
INNER JOIN ProjectEntityMaster PE ON PE.ProjectEntityCode = P.ProjectEntityCode
INNER JOIN ProjectSegmentMaster PS ON PS.ProjectSegmentCode= P.ProjectSegmentCode
INNER JOIN SmartViewCodeMaster SM ON SM.SmartViewCode =P.SmartViewCode
INNER JOIN BUCategoryMaster BU ON BU.BUCategoryCode = P.BUCategoryCode
INNER JOIN ScenarioData SD ON SD.ProjectID = P.ProjectID
INNER JOIN Scenario S ON S.ScenarioID = SD.ScenarioID
WHERE  S.ScenarioID=@P_ScenarioId 
AND 
SD.ScenarioDataTypeID IN (@V_AC_RVID,@V_AC_GMID) AND SD.[Year] = @P_Year 
AND S.ScenarioScopeCode = @V_ScenarioScopeCode AND S.ScenarioTypeCode = @V_ActualsScenarioTypeCode
Group By PE.ProjectEntityCode,PE.ProjectEntityName,SM.SmartViewCode,SM.SmartViewName,BU.BUCategoryCode,BU.BUCategoryName,
PS.ProjectSegmentCode,PS.ProjectSegmentName,SD.ScenarioDataTypeID,SD.Q1New,SD.Q2New,SD.Q3New,SD.Q4New;

SELECT ScenarioID,ScenarioName 
FROM Scenario WHERE ScenarioID=@P_ScenarioId;

END;
ELSE
BEGIN
SELECT DISTINCT PE.ProjectEntityCode,PE.ProjectEntityName,SM.SmartViewCode,SM.SmartViewName,
BU.BUCategoryCode,BU.BUCategoryName,PS.ProjectSegmentCode,PS.ProjectSegmentName,SD.ScenarioDataTypeID,SUM(SD.Q1New) Q1New,SUM(SD.Q2New) Q2New,SUM(SD.Q3New) Q3New,SUM(SD.Q4New) Q4New
FROM Project P
INNER JOIN ProjectEntityMaster PE ON PE.ProjectEntityCode = P.ProjectEntityCode
INNER JOIN ProjectSegmentMaster PS ON PS.ProjectSegmentCode= P.ProjectSegmentCode
INNER JOIN SmartViewCodeMaster SM ON SM.SmartViewCode =P.SmartViewCode
INNER JOIN BUCategoryMaster BU ON BU.BUCategoryCode = P.BUCategoryCode
INNER JOIN ScenarioData SD ON SD.ProjectID = P.ProjectID
INNER JOIN Scenario S ON S.ScenarioID = SD.ScenarioID 
WHERE  S.ScenarioID = @P_ScenarioId AND SD.ScenarioDataTypeID IN (@V_FC_RVID,@V_FC_GMID) AND SD.[Year] = @P_Year
AND S.ScenarioScopeCode = @V_ScenarioScopeCode AND S.ScenarioTypeCode = @V_ForeCastScenarioTypeCode
Group By PE.ProjectEntityCode,PE.ProjectEntityName,SM.SmartViewCode,SM.SmartViewName,BU.BUCategoryCode,BU.BUCategoryName,
PS.ProjectSegmentCode,PS.ProjectSegmentName,SD.ScenarioDataTypeID,SD.Q1New,SD.Q2New,SD.Q3New,SD.Q4New;

SELECT ScenarioID,ScenarioName 
FROM Scenario WHERE ScenarioID=@P_ScenarioId;

SELECT DISTINCT PE.ProjectEntityCode,PE.ProjectEntityName,SM.SmartViewCode,SM.SmartViewName,
BU.BUCategoryCode,BU.BUCategoryName,PS.ProjectSegmentCode,PS.ProjectSegmentName,SD.ScenarioDataTypeID,SUM(SD.Q1New) Q1New,SUM(SD.Q2New) Q2New,SUM(SD.Q3New) Q3New,SUM(SD.Q4New) Q4New
FROM Project P
INNER JOIN ProjectEntityMaster PE ON PE.ProjectEntityCode = P.ProjectEntityCode
INNER JOIN ProjectSegmentMaster PS ON PS.ProjectSegmentCode= P.ProjectSegmentCode
INNER JOIN SmartViewCodeMaster SM ON SM.SmartViewCode =P.SmartViewCode
INNER JOIN BUCategoryMaster BU ON BU.BUCategoryCode = P.BUCategoryCode
INNER JOIN ScenarioData SD ON SD.ProjectID = P.ProjectID
INNER JOIN Scenario S ON S.ScenarioID = SD.ScenarioID 
WHERE  S.ScenarioID = @P_ScenarioId AND SD.ScenarioDataTypeID IN (1,2) AND SD.[Year] = (@P_Year +1)
AND S.ScenarioScopeCode = @V_ScenarioScopeCode AND S.ScenarioTypeCode = @V_ForeCastScenarioTypeCode
Group By PE.ProjectEntityCode,PE.ProjectEntityName,SM.SmartViewCode,SM.SmartViewName,BU.BUCategoryCode,BU.BUCategoryName,
PS.ProjectSegmentCode,PS.ProjectSegmentName,SD.ScenarioDataTypeID,SD.Q1New,SD.Q2New,SD.Q3New,SD.Q4New;
END;

END;