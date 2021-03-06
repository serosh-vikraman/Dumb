CREATE  PROCEDURE [dbo].[ProjectLifeCycleReport]
@P_ProjectId int,
@P_CurrentYear int,
@P_ScenariotypeCode varchar(50)
	
AS
BEGIN

--   exec [ProjectLifeCycleReport] 280, 2020,'OI'

SELECT CASE WHEN ISNULL(IFSProjectCode,'X')<>'X' THEN IFSProjectCode
     
    ELSE ManualProjectCode  END ProjectCode, ProjectName  from Project where projectId=@P_ProjectId;


 select D.ScenarioScopeCode,B.[Year], c.ScenarioName, D.FinancialDataTypeCode, (isnull(B.Q1New,0)+ isnull(B.Q2New,0)+isnull(B.Q3New,0)+isnull(B.Q4New,0)) Amount from ScenarioData B
INNER JOIn FinancialDataTypesScenario D ON(B.ScenarioDataTypeID=D.ScenarioDataTypeID)
INNER  JOIN Scenario C ON(B.ScenarioID=C.ScenarioID) 
INNER JOIN (
select BB.ProjectID,AA.ScenarioScopeCode, AA.ScenarioTypeCode, AA.FinancialYear, max(AA.ScenarioID) ScenarioID, max(AA.ScenariosequenceNumber) ScenariosequenceNumber from Scenario
AA inner join ScenarioData BB on(AA.ScenarioID=BB.ScenarioID)
INNER JOIn FinancialDataTypesScenario DD ON(BB.ScenarioDataTypeID=DD.ScenarioDataTypeID)
 WHERE  AA.FinancialYear<@P_CurrentYear and BB.ProjectId=@P_ProjectId and AA.ScenariotypeCode='AC'
 AND DD.FinancialDataTypeCode in ('RV', 'GM') AND DD.ScenarioScopeCode=@P_ScenariotypeCode
group by AA.ScenarioScopeCode, AA.ScenarioTypeCode, AA.FinancialYear, BB.ProjectID
) E ON(B.ScenarioID=E.ScenarioID)
WHERE  B.ProjectId=@P_ProjectId AND    B.[Year]<@P_CurrentYear AND D.ScenarioScopeCode=@P_ScenariotypeCode
AND D.FinancialDataTypeCode in ('RV', 'GM') and C.ScenariotypeCode='AC'
ORDER BY B.[Year];


 select D.ScenarioScopeCode,b.[Year], c.ScenarioName, D.FinancialDataTypeCode, (isnull(B.Q1New,0)+ isnull(B.Q2New,0)+isnull(B.Q3New,0)+isnull(B.Q4New,0)) Amount from ScenarioData B
INNER JOIn FinancialDataTypesScenario D ON(B.ScenarioDataTypeID=D.ScenarioDataTypeID)
INNER  JOIN Scenario C ON(B.ScenarioID=C.ScenarioID) 
INNER JOIN (
select BB.ProjectID,AA.ScenarioScopeCode, AA.ScenarioTypeCode, AA.FinancialYear, max(AA.ScenarioID) ScenarioID, max(AA.ScenariosequenceNumber) ScenariosequenceNumber from Scenario
AA inner join ScenarioData BB on(AA.ScenarioID=BB.ScenarioID)
INNER JOIn FinancialDataTypesScenario DD ON(BB.ScenarioDataTypeID=DD.ScenarioDataTypeID)
 WHERE  AA.FinancialYear=@P_CurrentYear and BB.ProjectId=@P_ProjectId and AA.ScenariotypeCode='FC'
 AND DD.FinancialDataTypeCode in ('RV', 'GM') AND DD.ScenarioScopeCode=@P_ScenariotypeCode
group by AA.ScenarioScopeCode, AA.ScenarioTypeCode, AA.FinancialYear, BB.ProjectID
) E ON(B.ScenarioID=E.ScenarioID)
WHERE  B.ProjectId=@P_ProjectId AND    B.[Year]=@P_CurrentYear AND D.ScenarioScopeCode=@P_ScenariotypeCode
AND D.FinancialDataTypeCode in ('RV', 'GM') and C.ScenariotypeCode='FC'
ORDER BY B.[Year];


 select D.ScenarioScopeCode,b.[Year], c.ScenarioName, D.FinancialDataTypeCode, (isnull(B.Q1New,0)+ isnull(B.Q2New,0)+isnull(B.Q3New,0)+isnull(B.Q4New,0)) Amount from ScenarioData B
INNER JOIn FinancialDataTypesScenario D ON(B.ScenarioDataTypeID=D.ScenarioDataTypeID)
INNER  JOIN Scenario C ON(B.ScenarioID=C.ScenarioID) 
INNER JOIN (
select BB.ProjectID,AA.ScenarioScopeCode, AA.ScenarioTypeCode, AA.FinancialYear, max(AA.ScenarioID) ScenarioID, max(AA.ScenariosequenceNumber) ScenariosequenceNumber from Scenario
AA inner join ScenarioData BB on(AA.ScenarioID=BB.ScenarioID)
INNER JOIn FinancialDataTypesScenario DD ON(BB.ScenarioDataTypeID=DD.ScenarioDataTypeID)
 WHERE  AA.FinancialYear>@P_CurrentYear and BB.ProjectId=@P_ProjectId and AA.ScenariotypeCode='FC'
 AND DD.FinancialDataTypeCode in ('RV', 'GM') AND DD.ScenarioScopeCode=@P_ScenariotypeCode
group by AA.ScenarioScopeCode, AA.ScenarioTypeCode, AA.FinancialYear, BB.ProjectID
) E ON(B.ScenarioID=E.ScenarioID)
WHERE  B.ProjectId=@P_ProjectId AND    B.[Year]>@P_CurrentYear AND D.ScenarioScopeCode=@P_ScenariotypeCode
AND D.FinancialDataTypeCode in ('RV', 'GM') and C.ScenariotypeCode='FC'
ORDER BY B.[Year];
  
END;