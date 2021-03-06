USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[SaveScenario]    Script Date: 17-10-2020 06:24:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


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
	DECLARE @V_Message       VARCHAR(200)='Success';
	DECLARE @CountBD INT;
	Declare @V_Description varchar(500);
Declare @V_ScenarioLock bit;
Declare @V_LogDescription varchar(2000) ;
DECLARE @V_Lock   bit;
DECLARE @V_YearLock   bit;
Declare @V_SequenceNumber int;
declare @V_SeqCount int;

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
		Begin
			SET @Count = 1
			-- Lock Budget if ScenarioType is ForeCast or Actuals
			If (@P_ScenarioTypeCode = 'FC' or  @P_ScenarioTypeCode = 'AC') and (@P_ScenarioScopeCode<>'BL')
			Begin
			Select @V_Lock = ScenarioLock from Scenario where ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = 'BD'
					AND FinancialYear = @P_FinancialYear		
			SET @CountBD = (
				SELECT Count(1)
				FROM Scenario
				WHERE ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = 'BD'
					AND FinancialYear = @P_FinancialYear
				);
				If (@CountBD <> 0) 
				    Begin
                      If(@V_Lock <> 1)
			           begin
                        SET @isSuccess=0; 			   
                        SET @V_Message ='Budget for this year not locked'; 
			           end;
			        End;
			    else
			    begin
			      SET @isSuccess=0;
                  SET @V_Message ='Budget for this year and scope not created' ;		
			    end;
		    end;
		End    
		ELSE
		Begin

		--SET @Count = @Count + 1;
		Select @Count = Max(ScenarioSequenceNumber) from Scenario where ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = @P_ScenarioTypeCode
					AND FinancialYear = @P_FinancialYear
		SET @Count = @Count + 1;

		--return if trying to create Budget for same scope and year.
        If (@P_ScenarioTypeCode = 'BD') 
		begin 
		SET @isSuccess=0; 
		Set @V_Id = 0;
        SET @V_Message ='Budget for this year and scope already entered' 
		end;
		
		-- return if trying to create more than 4 forecast or actuals
		If (@Count > 4 and @P_ScenarioTypeCode='AC' ) 
		begin 
		SET @isSuccess=0; 
		Set @V_Id = 0;
        SET @V_Message ='Maximum of Four Actuals already entered.' 		
		end;
		End;
		 IF(@isSuccess=1) 
		 Begin
		--Lock all previous Forecast and Actuals of same financial year and scope
		UPDATE Scenario
		    SET 
		       [ScenarioLock] = 1
		      ,[UpdatedBy] = @P_CreatedBy
		      ,[UpdatedAt] = getdate()
		       WHERE [ScenarioScopeCode] = @P_ScenarioScopeCode and [FinancialYear] = @P_FinancialYear and ScenarioTypeCode=@P_ScenarioTypeCode
		    
		
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
				


         End;
	END
	
	ELSE
	BEGIN
	Select @ScenarioName = ScenarioName,@V_Description= [Description], @V_ScenarioLock= [ScenarioLock] 
	From Scenario where ScenarioID=@P_Id; 
	
	If (@P_ScenarioLock = 1) and (@P_ScenarioTypeCode = 'BD')
	Begin
	Select @V_YearLock = Lock from LockYear where [Year] =(@P_FinancialYear - 1);
	If (@V_YearLock =0)
	Begin
	 SET @isSuccess=0; 			   
     SET @V_Message ='Previous Year not locked.'; 
    End;
	End;

	If (@P_ScenarioLock = 0)
	Begin
	Select @V_YearLock = Lock from LockYear where [Year] =@P_FinancialYear;
	If (@V_YearLock =1)
	Begin
	 SET @isSuccess=0; 			   
     SET @V_Message ='Year locked.'; 
    End;
	Else
	Begin
	Select @V_SequenceNumber = ScenarioSequenceNumber from Scenario where ScenarioID = @P_Id;
	Select @V_SeqCount = count(1) from Scenario where [ScenarioScopeCode] = @P_ScenarioScopeCode and [ScenarioTypeCode] = @P_ScenarioTypeCode and  [FinancialYear] = @P_FinancialYear
	and ScenarioSequenceNumber > @V_SequenceNumber;
    If (@V_SeqCount >1) 
	Begin
	 SET @isSuccess=0; 			   
     SET @V_Message ='Only previous scenario of the latest scenario can be unlocked'; 
	End;
	End;
	End;   
	   IF(@isSuccess=1)  
		Begin
		UPDATE Scenario
		   SET 
		   --[ScenarioScopeCode] = @P_ScenarioScopeCode
		   --   ,[ScenarioTypeCode] = @P_ScenarioTypeCode
		   --   ,[FinancialYear] = @P_FinancialYear
		   --   ,[ScenarioSequenceNumber] = @P_ScenarioSequenceNumber
		      [Description] = @P_Description
		      ,[ScenarioLock] = @P_ScenarioLock
		      ,[UpdatedBy] = @P_CreatedBy
		      ,[UpdatedAt] = getdate()
		 WHERE ScenarioID=@P_Id; 
		SET @V_Id = @P_Id;
		IF @V_Description!=@P_Description
		SET @V_LogDescription = 'Description = '+@V_Description+' -> '+@P_Description;

	IF @V_ScenarioLock!=@P_ScenarioLock
		SET @V_LogDescription =@V_LogDescription + ', [ScenarioLock]= '+CAST( @V_ScenarioLock as varchar(10)) +' -> '+CAST( @P_ScenarioLock as varchar(10));
	End	 
		  
	
	END
	Exec LogActivity 'Scenario',@V_SubAction,@V_Id,@V_LogDescription,@P_CreatedBy;
 SELECT @V_Message,@V_Id,@ScenarioName ScenarioName ;
 
END