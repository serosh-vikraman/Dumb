USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[GetAllCurrencyExchange]    Script Date: 16-10-2020 06:59:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetAllCurrencyExchange] @P_Id INT
AS
BEGIN
	SELECT [Id]
	     ,[SourceCurrencyCode]
		,[TargetCurrencyCode]
		,[SourceCurrencyID]
		,[TargetCurrencyID]
		,[Year]
		,[Quarter]
		,[AverageRate]
		,[LockStatus]
		,CreatedBy
		,Case LockStatus When 0 then 'No' else 'Yes' End Status
	FROM [dbo].[CurrencyExchange]
	WHERE (Id = @P_Id)
		OR (@P_Id = 0) order by CreatedAt  desc;
END;
