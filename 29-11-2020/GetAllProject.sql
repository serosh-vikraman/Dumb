
ALTER PROCEDURE [dbo].[GetAllProject] @P_Id int
	
AS
BEGIN

SELECT p.ProjectID
      ,p.ProjectType
      ,p.IFSProjectCode
      ,p.ManualProjectCode
      ,p.ProjectName
      ,isnull (p.ProjectSegmentCode,'') ProjectSegmentCode
      ,isnull (p.ProjectEntityCode,'') ProjectEntityCode
      ,isnull (p.BUCategoryCode,'') BUCategoryCode
      ,isnull (p.StatutoryCategoryCode,'') StatutoryCategoryCode
      ,isnull (p.CountryCode,'') CountryCode
      ,isnull (p.BillingTypesCode,'') BillingTypesCode
      ,isnull (p.ContractTypeCode,'') ContractTypeCode
      ,isnull (p.ContractStatusCode,'') ContractStatusCode
      ,isnull (p.SmartViewCode,'') SmartViewCode
      ,isnull (p.GroupingParametersCode,'') GroupingParametersCode
      ,isnull (p.ManagementCategoryCode,'') ManagementCategoryCode
	  ,isnull (p.ClubbingParameterCode,'') ClubbingParameterCode
      ,p.Notes
      ,p.ProjectStatus
      ,p.CreatedBy
	  ,count(spm.ScenarioID) MappingCount
   
  FROM Project p left join ScenarioProjectMapper spm on p.ProjectID=spm.ProjectID 
  where (p.ProjectID=@P_Id or @P_Id=0)
  group by  p.ProjectID,p.ProjectType,p.IFSProjectCode,p.ManualProjectCode,p.ProjectName,p.ProjectSegmentCode,p.ProjectEntityCode,p.BUCategoryCode,p.StatutoryCategoryCode,p.CountryCode
      ,p.BillingTypesCode,p.ContractTypeCode,p.ContractStatusCode,p.SmartViewCode,p.GroupingParametersCode,p.ManagementCategoryCode,p.ClubbingParameterCode,p.Notes,p.ProjectStatus,p.CreatedBy
	  order by p.IFSProjectCode;	
END
