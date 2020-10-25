
ALTER PROCEDURE [dbo].[GetAllLockYear] @P_Year int
	
AS
BEGIN
	

SELECT [Id]
      ,[Year]
      ,[Lock]
      ,[CreatedBy]
	  ,Case Lock When 0 then 'Off' else 'On' End Status
	  FROM [dbo].[LockYear] where ([Year]=@P_Year or @P_Year=0);
END
