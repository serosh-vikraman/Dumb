

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
