USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[GetAllLockQuarter]    Script Date: 14-10-2020 04:33:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

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