 
CREATE PROCEDURE [dbo].[VarianceAnalysisReport]
@P_BaseScenarioId int,
@P_CompareScenarioId1 int,
@P_CompareScenarioId2 int,
@P_Year int,
@P_FinancialDataTypeID varchar(50)
	
AS
BEGIN

DECLARE @P_BaseScenario varchar(50);
DECLARE @P_CompareScenario1 varchar(50);
DECLARE @P_CompareScenario2 varchar(50);


SELECT @P_BaseScenario= S.[ScenarioName] FROM [dbo].[Scenario] S where S.[ScenarioID] =@P_BaseScenarioId;
SELECT @P_CompareScenario1= S.[ScenarioName] FROM [dbo].[Scenario] S where S.[ScenarioID] =@P_CompareScenarioId1;
SELECT @P_CompareScenario2= S.[ScenarioName] FROM [dbo].[Scenario] S where S.[ScenarioID] =@P_CompareScenarioId2;

-- EXEC [VarianceAnalysisReport] 229, 224, 14,2020,'RV';
SELECT AB.GroupingParametersCode,
 AB.ProjectNo,
 AB.ProjectName,
 AB.ProjectNo,
 AB.BaseQ1, 
AB.BaseQ2, 
AB.BaseQ3, 
AB.BaseQ4,
AB.TotalBase,
AB.CS1Q1, 
AB.CS1Q2, 
AB.CS1Q3, 
AB.CS1Q4,
AB.TotalCS1,
AB.CS2Q1, 
AB.CS2Q2, 
AB.CS2Q3, 
AB.CS2Q4,
AB.TotalCS2,
MC.ManagementCategoryName as ManagementCategoryCode,
PE.ProjectEntityName as ProjectEntityCode,
PS.ProjectSegmentName as ProjectSegmentCode,
CS.ContractStatusName as ContractStatusCode,
CT.ContractTypeName as ContractTypeCode,
@P_BaseScenario BaseScenario,
@P_CompareScenario1 CS1,
@P_CompareScenario1 CS2
FROM
(

SELECT
ISNULL(BS.ProjectNo,'') ProjectNo,
ISNULL(BS.GroupingParametersCode,'') GroupingParametersCode,
ISNULL(BS.ProjectName,'') ProjectName,
ISNULL(BS.ContractTypeCode,'') ContractTypeCode, 
ISNULL(BS.ProjectEntityCode,'') ProjectEntityCode, 
ISNULL(BS.ContractStatusCode,'') ContractStatusCode, 
ISNULL(BS.ProjectSegmentCode,'') ProjectSegmentCode, 
ISNULL(BS.ManagementCategoryCode,'') ManagementCategoryCode, 
BS.BaseQ1, 
BS.BaseQ2, 
BS.BaseQ3, 
BS.BaseQ4,
BS.BaseQ1+BS.BaseQ2+BS.BaseQ3+BS.BaseQ4 as TotalBase,
CS1.CS1Q1, 
CS1.CS1Q2, 
CS1.CS1Q3, 
CS1.CS1Q4,
CS1.CS1Q1+CS1.CS1Q2+CS1.CS1Q3+ CS1.CS1Q4 as TotalCS1,
CS2.CS2Q1, 
CS2.CS2Q2, 
CS2.CS2Q3, 
CS2.CS2Q4,
CS2.CS2Q1+CS2.CS2Q2+CS2.CS2Q3+ CS2.CS2Q4 as TotalCS2


FROM
(SELECT
   CASE
      ISNULL(P.ClubbingParameterCode, 'X') 
      WHEN
         'X' 
      THEN
         IIF( ISNULL(P.[ManualProjectCode], 'X') = 'X', P.[IFSProjectCode], P.[ManualProjectCode]) 
      ELSE
         P.ClubbingParameterCode 
   END
   as ProjectNo, 
   P.GroupingParametersCode, 
   MAX([ProjectName]) ProjectName,
   MAX([ContractTypeCode]) ContractTypeCode, 
   MAX([ProjectEntityCode]) ProjectEntityCode, 
   MAX([ContractStatusCode]) ContractStatusCode, 
   MAX([ProjectSegmentCode]) ProjectSegmentCode, 
   MAX([ManagementCategoryCode]) ManagementCategoryCode, 
   SUM([Q1New]) BaseQ1, 
   SUM([Q2New]) BaseQ2, 
   SUM([Q3New]) BaseQ3, 
   SUM([Q4New]) BaseQ4

from
   ScenarioData SD 
   INNER JOIN
      FinancialDataTypesScenario FD 
      ON(SD.ScenarioDataTypeID = FD.ScenarioDataTypeID) 
   INNER JOIN
      Project P 
      ON(SD.ProjectID = P.ProjectID) 
WHERE
   SD.ScenarioId = @P_BaseScenarioId 
   and FD.FinancialDataTypeCode =@P_FinancialDataTypeID
   and SD.[Year] = @P_Year 
GROUP BY
   CASE
      ISNULL(P.ClubbingParameterCode, 'X') 
      WHEN
         'X' 
      THEN
         IIF( ISNULL(P.[ManualProjectCode], 'X') = 'X', P.[IFSProjectCode], P.[ManualProjectCode]) 
      ELSE
         P.ClubbingParameterCode 
   END
, P.GroupingParametersCode) BS

LEFT JOIN 
(SELECT
   CASE
      ISNULL(P.ClubbingParameterCode, 'X') 
      WHEN
         'X' 
      THEN
         IIF( ISNULL(P.[ManualProjectCode], 'X') = 'X', P.[IFSProjectCode], P.[ManualProjectCode]) 
      ELSE
         P.ClubbingParameterCode 
   END
   AS ProjectNo, 
   P.GroupingParametersCode, 
   MAX([ProjectName]) ProjectName,
   MAX([ContractTypeCode]) ContractTypeCode, 
   MAX([ProjectEntityCode]) ProjectEntityCode, 
   MAX([ContractStatusCode]) ContractStatusCode, 
   MAX([ProjectSegmentCode]) ProjectSegmentCode, 
   MAX([ManagementCategoryCode]) ManagementCategoryCode, 
   SUM([Q1New]) CS1Q1, 
   SUM([Q2New]) CS1Q2, 
   SUM([Q3New]) CS1Q3, 
   SUM([Q4New]) CS1Q4

from
   ScenarioData SD 
   INNER JOIN
      FinancialDataTypesScenario FD 
      ON(SD.ScenarioDataTypeID = FD.ScenarioDataTypeID) 
   INNER JOIN
      Project P 
      ON(SD.ProjectID = P.ProjectID) 
WHERE
   SD.ScenarioId = @P_CompareScenarioId2 
   and FD.FinancialDataTypeCode =@P_FinancialDataTypeID
   and SD.[Year] = @P_Year 
GROUP BY
   CASE
      ISNULL(P.ClubbingParameterCode, 'X') 
      WHEN
         'X' 
      THEN
         IIF( ISNULL(P.[ManualProjectCode], 'X') = 'X', P.[IFSProjectCode], P.[ManualProjectCode]) 
      ELSE
         P.ClubbingParameterCode 
   END
, P.GroupingParametersCode) CS1
ON(BS.ProjectNo=CS1.ProjectNo AND BS.GroupingParametersCode=CS1.GroupingParametersCode)


LEFT JOIN 
(SELECT
   CASE
      ISNULL(P.ClubbingParameterCode, 'X') 
      WHEN
         'X' 
      THEN
         IIF( ISNULL(P.[ManualProjectCode], 'X') = 'X', P.[IFSProjectCode], P.[ManualProjectCode]) 
      ELSE
         P.ClubbingParameterCode 
   END
   AS ProjectNo, 
   P.GroupingParametersCode, 
   MAX([ProjectName]) ProjectName,
   MAX([ContractTypeCode]) ContractTypeCode, 
   MAX([ProjectEntityCode]) ProjectEntityCode, 
   MAX([ContractStatusCode]) ContractStatusCode, 
   MAX([ProjectSegmentCode]) ProjectSegmentCode, 
   MAX([ManagementCategoryCode]) ManagementCategoryCode, 
   SUM([Q1New]) CS2Q1, 
   SUM([Q2New]) CS2Q2, 
   SUM([Q3New]) CS2Q3, 
   SUM([Q4New]) CS2Q4

from
   ScenarioData SD 
   INNER JOIN
      FinancialDataTypesScenario FD 
      ON(SD.ScenarioDataTypeID = FD.ScenarioDataTypeID) 
   INNER JOIN
      Project P 
      ON(SD.ProjectID = P.ProjectID) 
WHERE
   SD.ScenarioId = @P_CompareScenarioId2 
   and FD.FinancialDataTypeCode =@P_FinancialDataTypeID
   and SD.[Year] = @P_Year 
GROUP BY
   CASE
      ISNULL(P.ClubbingParameterCode, 'X') 
      WHEN
         'X' 
      THEN
         IIF( ISNULL(P.[ManualProjectCode], 'X') = 'X', P.[IFSProjectCode], P.[ManualProjectCode]) 
      ELSE
         P.ClubbingParameterCode 
   END
, P.GroupingParametersCode) CS2
ON(BS.ProjectNo=CS2.ProjectNo AND BS.GroupingParametersCode=CS2.GroupingParametersCode)
) AB
LEFT JOIN ManagementCategoryMaster MC ON MC.ManagementCategoryCode = AB.ManagementCategoryCode 
LEFT JOIN  ProjectEntityMaster PE ON PE.ProjectEntityCode = AB.ProjectEntityCode 
LEFT JOIN ProjectSegmentMaster PS ON PS.ProjectSegmentCode =AB.ProjectSegmentCode
LEFT JOIN  ContractStatusMaster CS ON CS.ContractStatusCode = AB.ContractStatusCode  
LEFT JOIN ContractTypeMaster CT ON CT.ContractTypeCode =AB.ContractTypeCode 
ORDER BY 
AB.GroupingParametersCode,
 AB.ProjectNo;

  
END;
GO


