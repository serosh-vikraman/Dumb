
ALTER PROCEDURE [dbo].[DeleteContractStatusMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_ContractStatusName varchar(100);

SELECT @V_ContractStatusName = ContractStatusName FROM [ContractStatusMaster] WHERE ContractStatusID = @P_Id;
DELETE FROM [dbo].[ContractStatusMaster]
      WHERE ContractStatusID=@P_Id;

 Exec LogActivity 'ContractStatusMaster','DELETE',@P_Id,@V_ContractStatusName,@P_User;
 Select @P_Id;

END

