

ALTER PROCEDURE [dbo].[GetAllLockQuarter] @P_Id int
	
AS
BEGIN
	

SELECT [Id]
      ,[Year]
      ,[Quarter]
      ,[Lock]
      ,[CreatedBy]
	  ,Case Lock When 0 then 'Off' else 'On' End Status
	  FROM [dbo].[LockQuarter] where ([Id]=@P_Id or @P_Id=0) order by [Year]  asc;
END