
CREATE PROCEDURE [dbo].[GetAllClubbingParameter] @P_Id int
	
AS
BEGIN
	
	SELECT ClubbingParameterID,ClubbingParameterCode,ClubbingParameterName,CreatedBy,Active,Case Active When 1 then 'Active' else 'Inactive' End Status
	FROM ClubbingParameterMaster where (ClubbingParameterID=@P_Id or @P_Id=0) order by ClubbingParameterCode asc;
END
