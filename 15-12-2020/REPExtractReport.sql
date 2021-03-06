
ALTER  PROCEDURE [dbo].[REPExtractReport]
@P_Year int,
@P_ScenarioTypeCode varchar(50)
	
AS
BEGIN

IF @P_ScenarioTypeCode='AC'
BEGIN
SELECT [Year], Quarter, AverageRate, SourceCurrencyCode,TargetCurrencyCode  from CurrencyExchange 
where [Year]=@P_Year AND SourceCurrencyCode='EUR' AND TargetCurrencyCode='USD' AND CancelStatus=0
ORDER BY Quarter;

select 
B.[Year],
  P.SmartViewCode, 
  D.FinancialDataTypeCode, 
  C.ScenarioTypeCode,
  MAX(SC.SmartViewName) SmartViewName, 
  SUM(isnull(B.Q1New, 0)) Q1New, 
  SUM(isnull(B.Q2New, 0)) Q2New, 
  SUM(isnull(B.Q3New, 0)) Q3New, 
  SUM(isnull(B.Q4New, 0)) Q4New, 
  -- (isnull(B.Q1New,0)) Q1New, (isnull(B.Q2New,0)) Q2New,(isnull(B.Q3New,0)) Q3New,(isnull(B.Q4New,0)) Q4New,
  MAX(PE.ProjectEntityName) as ProjectEntityCode, 
  MAX(PS.ProjectSegmentName) as ProjectSegmentCode, 
  MAX(BU.BUCategoryName) as BUCategoryName, 
  MAX(SM.StatutoryCategoryName) as StatutoryCategoryName 
from 
  ScenarioData B 
  INNER JOIN ScenarioView SV on(B.ScenarioID = SV.ScenarioID) 
  INNER JOIn FinancialDataTypesScenario D ON(B.ScenarioDataTypeID = D.ScenarioDataTypeID) 
  INNER JOIN Scenario C ON(B.ScenarioID = C.ScenarioID) 
  INNER JOIN Project P on(B.ProjectID = P.ProjectID) 
  LEFT JOIN ProjectEntityMaster PE ON PE.ProjectEntityCode = P.ProjectEntityCode 
  LEFT JOIN ProjectSegmentMaster PS ON PS.ProjectSegmentCode = P.ProjectSegmentCode 
  LEFT JOIN SmartViewCodeMaster SC ON(P.SmartViewCode = SC.SmartViewCode) 
  LEFT JOIN BUCategoryMaster BU ON BU.BUCategoryCode = P.BUCategoryCode 
  LEFT JOIN StatutoryCategoryMaster SM ON SM.StatutoryCategoryCode = P.StatutoryCategoryCode 
WHERE 
  D.ScenarioScopeCode = 'PL' 
AND C.ScenarioTypeCode =@P_ScenarioTypeCode
AND D.FinancialDataTypeCode in ('RV', 'GM') 
AND isnull(P.SmartViewCode, 'X')!= 'X' 
AND B.[Year]=@P_Year
GROUP BY 
B.[Year],
  P.SmartViewCode, 
  D.FinancialDataTypeCode,
  C.ScenariotypeCode
ORDER BY 
B.[Year],
  P.SmartViewCode, 
  D.FinancialDataTypeCode DESC,
  C.ScenariotypeCode;

  END;
  ELSE
 BEGIN
 SELECT [Year], Quarter, AverageRate, SourceCurrencyCode,TargetCurrencyCode  from CurrencyExchange 
where [Year]>=@P_Year AND SourceCurrencyCode='EUR' AND TargetCurrencyCode='USD' AND CancelStatus=0
ORDER BY [Year],Quarter;

select 
B.[Year],
  P.SmartViewCode, 
  D.FinancialDataTypeCode, 
  C.ScenarioTypeCode,
  MAX(SC.SmartViewName) SmartViewName, 
  SUM(isnull(B.Q1New, 0)) Q1New, 
  SUM(isnull(B.Q2New, 0)) Q2New, 
  SUM(isnull(B.Q3New, 0)) Q3New, 
  SUM(isnull(B.Q4New, 0)) Q4New, 
  -- (isnull(B.Q1New,0)) Q1New, (isnull(B.Q2New,0)) Q2New,(isnull(B.Q3New,0)) Q3New,(isnull(B.Q4New,0)) Q4New,
  MAX(PE.ProjectEntityName) as ProjectEntityCode, 
  MAX(PS.ProjectSegmentName) as ProjectSegmentCode, 
  MAX(BU.BUCategoryName) as BUCategoryName, 
  MAX(SM.StatutoryCategoryName) as StatutoryCategoryName 
from 
  ScenarioData B 
  INNER JOIN ScenarioView SV on(B.ScenarioID = SV.ScenarioID) 
  INNER JOIn FinancialDataTypesScenario D ON(B.ScenarioDataTypeID = D.ScenarioDataTypeID) 
  INNER JOIN Scenario C ON(B.ScenarioID = C.ScenarioID) 
  INNER JOIN Project P on(B.ProjectID = P.ProjectID) 
  LEFT JOIN ProjectEntityMaster PE ON PE.ProjectEntityCode = P.ProjectEntityCode 
  LEFT JOIN ProjectSegmentMaster PS ON PS.ProjectSegmentCode = P.ProjectSegmentCode 
  LEFT JOIN SmartViewCodeMaster SC ON(P.SmartViewCode = SC.SmartViewCode) 
  LEFT JOIN BUCategoryMaster BU ON BU.BUCategoryCode = P.BUCategoryCode 
  LEFT JOIN StatutoryCategoryMaster SM ON SM.StatutoryCategoryCode = P.StatutoryCategoryCode 
WHERE 
  D.ScenarioScopeCode = 'PL' 
AND C.ScenarioTypeCode =@P_ScenarioTypeCode
AND D.FinancialDataTypeCode in ('RV', 'GM') 
AND isnull(P.SmartViewCode, 'X')!= 'X' 
AND B.[Year]>=@P_Year
GROUP BY
B.[Year],
  P.SmartViewCode, 
  D.FinancialDataTypeCode,
  C.ScenariotypeCode
ORDER BY 
  B.[Year],
  P.SmartViewCode, 
  D.FinancialDataTypeCode DESC,
  C.ScenariotypeCode;
 END;

  END;
