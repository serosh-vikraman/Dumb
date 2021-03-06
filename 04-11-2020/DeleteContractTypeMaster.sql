
ALTER PROCEDURE [dbo].[DeleteContractTypeMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN

DECLARE @V_ContractTypeName varchar(100);

SELECT @V_ContractTypeName = ContractTypeName FROM [ContractTypeMaster] WHERE ContractTypeID = @P_Id;

DELETE FROM [dbo].[ContractTypeMaster]
      WHERE ContractTypeID=@P_Id;

 Exec LogActivity 'ContractTypeMaster','DELETE',@P_Id,@V_ContractTypeName,@P_User;
 Select @P_Id;

END
