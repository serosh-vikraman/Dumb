 
CREATE PROCEDURE [dbo].[GetProjectByClubbingParam] @P_ClubParam varchar(500)
	
AS
BEGIN
	
 

SELECT TOP 1 p.ProjectID
      
      ,isnull (MC.ManagementCategoryName,'') ManagementCategoryCode
      ,isnull (PE.ProjectEntityName,'') ProjectEntityCode
      ,isnull (PS.ProjectSegmentName,'') ProjectSegmentCode
      
      ,isnull (CT.ContractTypeName,'') ContractTypeCode
      ,isnull (CS.ContractStatusName ,'') ContractStatusCode 
        
   
  FROM Project p
  INNER JOIN ClubbingParameterMaster CL on(P.ClubbingParameterCode=CL.ClubbingParameterCode)
  LEFT JOIN ManagementCategoryMaster MC ON MC.ManagementCategoryCode = p.ManagementCategoryCode 
LEFT JOIN  ProjectEntityMaster PE ON PE.ProjectEntityCode = p.ProjectEntityCode 
LEFT JOIN ProjectSegmentMaster PS ON PS.ProjectSegmentCode =p.ProjectSegmentCode
LEFT JOIN  ContractStatusMaster CS ON CS.ContractStatusCode = p.ContractStatusCode  
LEFT JOIN ContractTypeMaster CT ON CT.ContractTypeCode =p.ContractTypeCode 
WHERE P.ClubbingParameterCode=@P_ClubParam
  ORDER BY P.ProjectID ASC ;

END
GO


