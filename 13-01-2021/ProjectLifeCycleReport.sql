 
 
ALTER  PROCEDURE [dbo].[ProjectLifeCycleReport]
@P_ProjectId int,
@P_CurrentYear int,
@P_ScenariotypeCode varchar(50)
	
AS
BEGIN

  --  exec [ProjectLifeCycleReport] 854, 2021,'PL'

SELECT CASE WHEN ISNULL(IFSProjectCode,'X')<>'X' THEN IFSProjectCode
     
    ELSE ManualProjectCode  END ProjectCode, ProjectName  from Project where projectId=@P_ProjectId;


 select D.ScenarioScopeCode,B.[Year], c.ScenarioName, D.FinancialDataTypeCode, (isnull(B.Q1New,0)+ isnull(B.Q2New,0)+isnull(B.Q3New,0)+isnull(B.Q4New,0)) Amount from ScenarioData B
INNER JOIn FinancialDataTypesScenario D ON(B.ScenarioDataTypeID=D.ScenarioDataTypeID)
INNER  JOIN Scenario C ON(B.ScenarioID=C.ScenarioID) 
INNER JOIN ScenarioView E ON(B.ScenarioID=E.ScenarioID)
WHERE  B.ProjectId=@P_ProjectId AND    B.[Year]<@P_CurrentYear AND D.ScenarioScopeCode=@P_ScenariotypeCode
AND D.FinancialDataTypeCode in ('RV', 'GM') and C.ScenariotypeCode='AC'
  AND E.ScenarioScopeCode=@P_ScenariotypeCode And E.ScenariotypeCode='AC'
ORDER BY B.[Year];


 select D.ScenarioScopeCode,b.[Year], c.ScenarioName, D.FinancialDataTypeCode, (isnull(B.Q1New,0)+ isnull(B.Q2New,0)+isnull(B.Q3New,0)+isnull(B.Q4New,0)) Amount from ScenarioData B
INNER JOIn FinancialDataTypesScenario D ON(B.ScenarioDataTypeID=D.ScenarioDataTypeID)
INNER  JOIN Scenario C ON(B.ScenarioID=C.ScenarioID) 
INNER JOIN ScenarioView E ON(B.ScenarioID=E.ScenarioID)
WHERE  B.ProjectId=@P_ProjectId AND    B.[Year]=@P_CurrentYear AND D.ScenarioScopeCode=@P_ScenariotypeCode
AND D.FinancialDataTypeCode in ('RV', 'GM') and C.ScenariotypeCode='FC'
  AND E.ScenarioScopeCode=@P_ScenariotypeCode And E.ScenariotypeCode='FC'
ORDER BY B.[Year];


 select D.ScenarioScopeCode,b.[Year], c.ScenarioName, D.FinancialDataTypeCode, (isnull(B.Q1New,0)+ isnull(B.Q2New,0)+isnull(B.Q3New,0)+isnull(B.Q4New,0)) Amount from ScenarioData B
INNER JOIn FinancialDataTypesScenario D ON(B.ScenarioDataTypeID=D.ScenarioDataTypeID)
INNER  JOIN Scenario C ON(B.ScenarioID=C.ScenarioID) 
INNER JOIN ScenarioView E ON(B.ScenarioID=E.ScenarioID)
WHERE  B.ProjectId=@P_ProjectId AND    B.[Year]>@P_CurrentYear AND D.ScenarioScopeCode=@P_ScenariotypeCode
AND D.FinancialDataTypeCode in ('RV', 'GM') and C.ScenariotypeCode='FC'
  AND E.ScenarioScopeCode=@P_ScenariotypeCode And E.ScenariotypeCode='FC'
ORDER BY B.[Year];
  
END;