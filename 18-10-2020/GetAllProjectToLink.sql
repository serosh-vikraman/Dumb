USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[GetAllProjectToLink]    Script Date: 14-10-2020 04:40:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetAllProjectToLink] 
	 
AS
Begin	

SELECT distinct m.[project_short_title] ProjectName
      ,m.[project_code]	ProjectCode,  p.IFSProjectCode
	  FROM [dbo].[MEREF_VW_Project] m left join  [dbo].[Project] p on (m.project_code = p.IFSProjectCode)
	 where p.IFSProjectCode is null order by ProjectName asc

END
