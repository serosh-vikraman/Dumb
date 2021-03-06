

ALTER PROCEDURE [dbo].[SaveScenario] @P_Id INT
	,@P_ScenarioScopeCode VARCHAR(5)
	,@P_ScenarioTypeCode VARCHAR(5)
	,@P_FinancialYear INT
	,@P_Description VARCHAR(3000)
	,@P_ScenarioLock BIT
	,@P_CreatedBy varchar(50)
	
AS
BEGIN
	DECLARE @V_Id INT=0;
	DECLARE @Count INT;
	DECLARE @ScenarioName VARCHAR(100);
	Declare @V_SubAction varchar(100);	
	DECLARE @isSuccess       INT = 1;
	DECLARE @V_MessageCode      VARCHAR(20)='SSS';
	DECLARE @V_Message      VARCHAR(250);
	DECLARE @CountBD INT;
	DECLARE @V_Description varchar(500);
	DECLARE @V_ScenarioLock bit;
	DECLARE @V_LogDescription varchar(2000) ;
	DECLARE @V_Lock   bit;
	DECLARE @V_YearLock   bit;
	DECLARE @V_SequenceNumber int;
	DECLARE @V_SeqCount int;
	DECLARE @V_LegacyInsertionFlag bit;

	SET @V_LegacyInsertionFlag = (SELECT TOP(1) LegacyInsertionFlag FROM LegacyInsertion);

	IF (@P_Id = 0)
	BEGIN

		SET @Count = (
				SELECT Count(1)
				FROM Scenario
				WHERE ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = @P_ScenarioTypeCode
					AND FinancialYear = @P_FinancialYear
				);
				
		IF @Count = 0
		BEGIN
			SET @Count = 1
			-- Check if Budget is locked for ScenarioType ForeCast or Actuals
			IF (@P_ScenarioTypeCode = 'FC' or  @P_ScenarioTypeCode = 'AC') and (@P_ScenarioScopeCode<>'BL')
			BEGIN
				SELECT @V_Lock = ScenarioLock from Scenario where ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = 'BD'
					AND FinancialYear = @P_FinancialYear		
				SET @CountBD = (
				SELECT Count(1)
				FROM Scenario
				WHERE ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = 'BD'
					AND FinancialYear = @P_FinancialYear
				);
				IF (@CountBD <> 0) 
				BEGIN
                      IF(@V_Lock <> 1)
			           BEGIN
                        SET @isSuccess=0; 			   
                        SET @V_MessageCode ='BDYNL'; 
			           END;
			    END;
			    ELSE
			    BEGIN
			      SET @isSuccess=0;
                  SET @V_MessageCode ='BDYSNC' ;		
			    END;
		    END;
		END   
		
		ELSE

		BEGIN
			SELECT @Count = Max(ScenarioSequenceNumber) from Scenario where ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = @P_ScenarioTypeCode
					AND FinancialYear = @P_FinancialYear
			SET @Count = @Count + 1;

			--return if trying to create Budget for same scope and year.
			IF (@P_ScenarioTypeCode = 'BD') 
			BEGIN 
				SET @isSuccess=0; 
				SET @V_Id = 0;
				SET @V_MessageCode ='BDYSAE' 
			END;
		
			-- return if trying to create more than 4 forecast or actuals
			IF (@Count > 4 and @P_ScenarioTypeCode='AC' ) 
			BEGIN 
				SET @isSuccess=0; 
				SET @V_Id = 0;
				SET @V_MessageCode ='MFAAE' 		
			END;
		END;

		IF(@isSuccess = 1 OR @V_LegacyInsertionFlag = 1) 
		BEGIN

		IF (@V_LegacyInsertionFlag = 1) SET @V_MessageCode = 'SSS';
			--Lock all previous Forecast and Actuals of same financial year and scope
			UPDATE Scenario
		    SET 
		       [ScenarioLock] = 1
		      ,[UpdatedBy] = @P_CreatedBy
		      ,[UpdatedAt] = getdate()
		       WHERE [ScenarioScopeCode] = @P_ScenarioScopeCode and [FinancialYear] = @P_FinancialYear and ScenarioTypeCode=@P_ScenarioTypeCode;		    
		
			SET @ScenarioName = CONCAT (
				@P_FinancialYear
				,'-'
				,@P_ScenarioScopeCode
				,'-'
				,@P_ScenarioTypeCode
				,'-'
				,@Count
				);

			INSERT INTO Scenario (
				ScenarioScopeCode
				,ScenarioTypeCode
				,FinancialYear
				,ScenarioSequenceNumber
				,ScenarioName
				,[Description]
				,ScenarioLock
				,CreatedBy
				,CreatedAt
				)
			VALUES (
				@P_ScenarioScopeCode
				,@P_ScenarioTypeCode
				,@P_FinancialYear
				,@Count
				,@ScenarioName
				,@P_Description
				,@P_ScenarioLock
				,@P_CreatedBy
				,getdate()
				)

			SET @V_Id = @@IDENTITY;
			SET @V_SubAction='SAVE';

			--Adding Applicable years
		
			INSERT INTO [dbo].[ScenarioApplicableYears] (
				[ScenarioId]
				,[Year1]
				,[Year2]
				,[Year3]
				,[Year4]
				,[Year5]
				,[CreatedBy]
				,[CreatedAt]
				)
			VALUES (
				@V_Id,@P_FinancialYear,@P_FinancialYear +1 ,@P_FinancialYear +2,@P_FinancialYear +3,@P_FinancialYear +4,@P_CreatedBy,GETDATE());
         END;
	END
	
	ELSE

	BEGIN
		SELECT @ScenarioName = ScenarioName,@V_Description= [Description], @V_ScenarioLock= [ScenarioLock] 
		FROM Scenario WHERE ScenarioID=@P_Id; 
	
		IF (@P_ScenarioLock = 1) and (@P_ScenarioTypeCode = 'BD')
		BEGIN
			SELECT @V_YearLock = Lock FROM LockYear WHERE [Year] =(@P_FinancialYear - 1);
			If (@V_YearLock IS NULL OR @V_YearLock = 0) 
			BEGIN
				SET @isSuccess=0; 			   
				SET @V_MessageCode ='PYNL'; 
			END;
		END;

		IF (@P_ScenarioLock = 0 and @V_ScenarioLock = 1)
		BEGIN
			SELECT @V_YearLock = Lock from LockYear WHERE [Year] = @P_FinancialYear;
			IF (@V_YearLock =1)
			BEGIN
				SET @isSuccess=0; 			   
				SET @V_MessageCode ='YL'; 
			END;
			ELSE
			BEGIN
				SELECT @V_SequenceNumber = ScenarioSequenceNumber from Scenario WHERE ScenarioID = @P_Id;
				SELECT @V_SeqCount = count(1) from Scenario where [ScenarioScopeCode] = @P_ScenarioScopeCode and [ScenarioTypeCode] = @P_ScenarioTypeCode and  [FinancialYear] = @P_FinancialYear
					and ScenarioSequenceNumber > @V_SequenceNumber;
				IF (@V_SeqCount <> 0) 
				BEGIN
					SET @isSuccess=0; 			   
					SET @V_MessageCode ='OLSU'; 
				END;
				SELECT @V_SeqCount = Count(1) from Scenario where (ScenarioTypeCode = 'FC' OR ScenarioTypeCode = 'AC')  and  (FinancialYear = @P_FinancialYear) and (ScenarioScopeCode = @P_ScenarioScopeCode)
				IF (@V_SeqCount <> 0) and (@P_ScenarioTypeCode = 'BD') 
				BEGIN
					SET @isSuccess=0; 			   
					SET @V_MessageCode ='FAAE'; 
				END;
			END;
		END;   
		IF (@isSuccess=1) OR (@V_LegacyInsertionFlag = 1)  
		BEGIN
		IF (@V_LegacyInsertionFlag = 1) SET @V_MessageCode = 'SSS';
			UPDATE Scenario
			SET 
		       [Description] = @P_Description
		      ,[ScenarioLock] = @P_ScenarioLock
		      ,[UpdatedBy] = @P_CreatedBy
		      ,[UpdatedAt] = getdate()
			WHERE ScenarioID=@P_Id; 
      
			IF (@P_ScenarioLock = 1)
			BEGIN
				UPDATE Scenario
					SET [ScenarioLock] = @P_ScenarioLock
						,[UpdatedBy] = @P_CreatedBy
						,[UpdatedAt] = getdate()
						WHERE [ScenarioScopeCode] = @P_ScenarioScopeCode and [ScenarioTypeCode] = @P_ScenarioTypeCode and [FinancialYear] = @P_FinancialYear
			END;

			SET @V_Id = @P_Id;
			IF @V_Description!=@P_Description
			SET @V_LogDescription = 'Description = '+@V_Description+' -> '+@P_Description;

			IF @V_ScenarioLock!=@P_ScenarioLock
			SET @V_LogDescription =@V_LogDescription + ', [ScenarioLock]= '+CAST( @V_ScenarioLock as varchar(10)) +' -> '+CAST( @P_ScenarioLock as varchar(10));
		END	 		  
	
	END
	Exec LogActivity 'Scenario',@V_SubAction,@V_Id,@V_LogDescription,@P_CreatedBy;
	SET @V_Message = (SELECT [Message] FROM dbo.[Messages] WHERE MessageCode = @V_MessageCode);
	SELECT @V_Message,@V_Id,@ScenarioName ScenarioName ;

END