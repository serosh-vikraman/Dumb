
ALTER PROCEDURE [dbo].[DeleteCountryMaster] @P_Id int, @P_User varchar(100)
	
AS
BEGIN
DECLARE @V_CountryName varchar(100);

SELECT @V_CountryName = CountryName FROM [CountryMaster] WHERE CountryID = @P_Id;
DELETE FROM [dbo].[CountryMaster]
      WHERE CountryID=@P_Id;

 Exec LogActivity 'CountryMaster','DELETE',@P_Id,@V_CountryName,@P_User;
 Select @P_Id;

END

