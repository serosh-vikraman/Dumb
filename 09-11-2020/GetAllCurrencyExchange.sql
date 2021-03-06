
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
		,[CancelStatus]
		,CreatedBy
		,Case LockStatus When 0 then 'Not Locked' else 'Locked' End Status
		,Case CancelStatus When 0 then 'Active' else 'Cancelled' End CancelActiveStatus
	FROM [dbo].[CurrencyExchange]
	WHERE (Id = @P_Id)
		OR (@P_Id = 0) order by CreatedAt  desc;
END;
