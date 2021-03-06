USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[SaveCurrencyExchange]    Script Date: 16-10-2020 07:01:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SaveCurrencyExchange] @P_Id INT
	,@P_SourceCurrencyId INT
	,@P_TargetCurrencyID INT
	,@P_Year INT
	,@P_Quarter VARCHAR(50)
	,@P_AverageRate DECIMAL(18, 5)
	,@P_LockStatus BIT
	--,@P_CancelStatus BIT
	,@P_CreatedBy VARCHAR(50)
AS
BEGIN
	DECLARE @V_Id INT;
	Declare @V_SubAction varchar(100); 
Declare @V_LogDescription varchar(2000);
Declare @V_SourceCurrencyId INT;
Declare @V_SourceCurrencyCode VARCHAR(30);
Declare @V_TargetCurrencyID INT;
Declare @V_TargetCurrencyCode VARCHAR(30);
Declare @V_Year INT;
Declare @V_Quarter VARCHAR(50);
Declare @V_AverageRate DECIMAL(18, 5);
Declare @V_LockStatus BIT;
--Declare @V_CancelStatus BIT;
DECLARE @VC_SourceCurrencyCode varchar(30);
DECLARE @VC_TargetCurrencyCode varchar(30);

	Select @VC_SourceCurrencyCode= CurrencyCode from CurrencyMaster where CurrencyID = @P_SourceCurrencyId;
	Select @VC_TargetCurrencyCode= CurrencyCode from CurrencyMaster where CurrencyID = @P_TargetCurrencyID;


	IF @P_Id = 0
	BEGIN
		INSERT INTO [dbo].[CurrencyExchange] (
			[SourceCurrencyID]
			,[SourceCurrencyCode]
			,[TargetCurrencyID]
			,[TargetCurrencyCode]
			,[Year]
			,[Quarter]
			,[AverageRate]
			,[LockStatus]
			--,[CancelStatus]
			,[CreatedBy]
			,[CreatedAt]
			)
		VALUES (
			@P_SourceCurrencyId
			 ,@VC_SourceCurrencyCode
			,@P_TargetCurrencyID
			,@VC_TargetCurrencyCode
			,@P_Year
			,@P_Quarter
			,@P_AverageRate
			,@P_LockStatus
			--,@P_CancelStatus
			,@P_CreatedBy
			,GETDATE()
			)
SET @V_SubAction='SAVE';
		SET @V_Id = @@IDENTITY;
	END;
	ELSE
	BEGIN
	SET @V_SubAction='UPDATE';
	SELECT
	@V_SourceCurrencyId=[SourceCurrencyID]
	,@V_SourceCurrencyCode=		[SourceCurrencyCode]
			,@V_TargetCurrencyID=[TargetCurrencyID]
			,@V_TargetCurrencyCode=[TargetCurrencyCode]
			,@V_Year=[Year]
			,@V_Quarter=[Quarter]
			,@V_AverageRate=[AverageRate]
			,@V_LockStatus=[LockStatus]
			--,@V_CancelStatus=[CancelStatus]

			FROM [dbo].[CurrencyExchange]
	WHERE Id = @P_Id;
		UPDATE [dbo].[CurrencyExchange]
		SET 
		    [SourceCurrencyID] = @P_SourceCurrencyId
			,[TargetCurrencyID] = @P_TargetCurrencyID
			,[SourceCurrencyCode] = @VC_SourceCurrencyCode
			,[TargetCurrencyCode] = @VC_TargetCurrencyCode
			,[Year] = @P_Year
			,[Quarter] = @P_Quarter
			,[AverageRate] = @P_AverageRate
			,[LockStatus] = @P_LockStatus
			--,[CancelStatus] = @P_CancelStatus
			,[UpdatedBy] = @P_CreatedBy
			,[UpdatedAt] = GETDATE()
			
		WHERE Id = @P_Id;

		SET @V_Id = @P_Id;


		IF @V_SourceCurrencyId!=@P_SourceCurrencyId 
			SET @V_LogDescription =  '[SourceCurrencyID]= '+CAST(@V_SourceCurrencyId as varchar(10))+' -> '+CAST(@P_SourceCurrencyId as varchar(10));
		IF @V_SourceCurrencyCode!=@VC_SourceCurrencyCode
			SET @V_LogDescription =@V_LogDescription + ', [SourceCurrencyCode]= '+@V_SourceCurrencyCode+' -> '+@VC_SourceCurrencyCode;
		IF @V_TargetCurrencyID!=@P_TargetCurrencyID
			SET @V_LogDescription =@V_LogDescription + ', [TargetCurrencyID]= '+CAST(@V_TargetCurrencyID as varchar(10))+' -> '+CAST(@P_TargetCurrencyID as varchar(10));
		IF @V_TargetCurrencyCode!=@VC_TargetCurrencyCode
			SET @V_LogDescription =@V_LogDescription + ', [TargetCurrencyCode]= '+@V_TargetCurrencyCode+' -> '+@VC_TargetCurrencyCode;
		IF @V_Year!=@P_Year
			SET @V_LogDescription =@P_Quarter + ', [Year]= '+CAST(@V_Year as varchar(10))+' -> '+CAST(@P_Year as varchar(10));
		IF @V_Quarter!=@P_Quarter
			SET @V_LogDescription =@V_LogDescription + ', [Quarter]= '+@V_Quarter+' -> '+@P_Quarter;
			IF @V_AverageRate!=@P_AverageRate
			SET @V_LogDescription =@V_LogDescription + ', [AverageRate]= '+CAST(@V_AverageRate as varchar(20))+' -> '+CAST(@P_AverageRate as varchar(20));

			IF @V_LockStatus!=@P_LockStatus
			SET @V_LogDescription =@V_LogDescription + ', [LockStatus]= '+CAST(@V_LockStatus as varchar(20))+' -> '+CAST(@P_LockStatus as varchar(20));
			--IF @V_CancelStatus!=@P_CancelStatus
			--SET @V_LogDescription =@V_LogDescription + ', [CancelStatus]= '+CAST(@V_CancelStatus as varchar(20))+' -> '+CAST(@P_CancelStatus as varchar(20));
	END;
	Exec LogActivity 'CurrencyExchange',@V_SubAction,@V_Id,@V_LogDescription,@P_CreatedBy;
	SELECT @V_Id,@VC_SourceCurrencyCode,@VC_TargetCurrencyCode;
END;
