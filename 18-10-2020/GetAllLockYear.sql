USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[GetAllLockYear]    Script Date: 14-10-2020 04:36:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
