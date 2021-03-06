

ALTER PROCEDURE [dbo].[DuplicateScenario] @P_ScenarioId INT
	,@P_ScenarioScopeCode VARCHAR(5)
	,@P_ScenarioTypeCode VARCHAR(5)
	,@P_FinancialYear INT
	,@P_Description VARCHAR(200)
	,@P_CreatedBy varchar(50)
	
	
AS
BEGIN
	DECLARE @V_Id INT=0;
	DECLARE @V_Count INT;
	DECLARE @V_FinancialYear INT;
	DECLARE @V_ScenarioName VARCHAR(100);
	DECLARE @V_ScenarioTypeCode VARCHAR(5);
	DECLARE @V_ProjectId INT;
	DECLARE @isSuccess       INT = 1;
	DECLARE @V_Message       VARCHAR(200);
	DECLARE @CountBD INT;
	DECLARE @V_Lock   bit;
	DECLARE @V_MessageCode      VARCHAR(20)='DSS';
	DECLARE @ScenarioName VARCHAR(100);
	DECLARE @V_LogDescription VARCHAR(100);
	DECLARE @V_ScenarioLock   bit;

	SELECT  @V_ScenarioTypeCode= ScenarioTypeCode ,@V_FinancialYear = FinancialYear,@ScenarioName = ScenarioName  from Scenario where ScenarioID = @P_ScenarioId;	
	SET  @V_Lock = (SELECT Lock from LockYear WHERE [Year] = @V_FinancialYear);
	SET @V_ScenarioLock = (SELECT ScenarioLock from Scenario WHERE ScenarioID = @P_ScenarioId);
		If (@V_Lock = 1)
		BEGIN
			SET @isSuccess = 0; SET @V_MessageCode = 'YL';
		END;
		If (@V_FinancialYear <> @P_FinancialYear) and (@V_ScenarioTypeCode <> 'FC')
		BEGIN
			SET @isSuccess = 0; SET @V_MessageCode = 'DFCY';
		END;
		If (@V_ScenarioTypeCode = 'FC') and (@P_FinancialYear > @V_FinancialYear +1)
		BEGIN
			SET @isSuccess = 0; SET @V_MessageCode = 'DFCNY';
		END;
		If (@V_ScenarioLock = 1)
		BEGIN
			SET @isSuccess = 0; SET @V_MessageCode = 'SL';
		END;

	IF (@isSuccess = 1)
	Begin

	SET @V_Count = (
				SELECT Count(1)
				FROM Scenario
				WHERE ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = @P_ScenarioTypeCode
					AND FinancialYear = @P_FinancialYear
				);

		IF @V_Count = 0
		BEGIN
			SET @V_Count = 1;
			-- Lock Budget if ScenarioType is ForeCast or Actuals
			If @P_ScenarioTypeCode = 'FC' or  @P_ScenarioTypeCode = 'AC'
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
                        SET @V_MessageCode ='BDYNL'; 
			           end;
			        End;
			    else
			    begin
			      SET @isSuccess=0;
                  SET @V_MessageCode ='BDYSNC' 		
			    end;
		    end;
		END
		ELSE
		BEGIN
		Select @V_Count = Max(ScenarioSequenceNumber) from Scenario where ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = @P_ScenarioTypeCode
					AND FinancialYear = @P_FinancialYear
		SET @V_Count = @V_Count + 1;

		If @P_ScenarioTypeCode = 'BD'
		 begin
			   SET @isSuccess=0; 
               SET @V_MessageCode ='DBOY' 		
		 end;
		 -- return if trying to create more than 4 actuals
		If (@V_Count > 4 and @P_ScenarioTypeCode='AC' ) 
		begin 
		SET @isSuccess=0; 		
        SET @V_MessageCode ='MFAAE' 		
		end;
      
		END

		If (@isSuccess = 1)
		begin
		-- Locking the scenario as same scenario code type year getting duplicated.
		UPDATE [dbo].[Scenario]
			SET 
				[ScenarioLock] = 1
				,[UpdatedBy] = @P_CreatedBy
				,[UpdatedAt] = getdate()
			WHERE ScenarioID = @P_ScenarioID or (ScenarioScopeCode = @P_ScenarioScopeCode
					AND ScenarioTypeCode = @P_ScenarioTypeCode
					AND FinancialYear = @P_FinancialYear);

		SET @V_ScenarioName = CONCAT (@P_FinancialYear,'-',@P_ScenarioScopeCode,'-',@P_ScenarioTypeCode,'-',@V_Count);

--Inserting new scenario
		INSERT INTO Scenario (ScenarioScopeCode,ScenarioTypeCode,FinancialYear,ScenarioSequenceNumber,ScenarioName,[Description],CreatedBy,CreatedAt)
		VALUES (@P_ScenarioScopeCode,@P_ScenarioTypeCode,@P_FinancialYear,@V_Count,@V_ScenarioName,@P_Description,@P_CreatedBy,getdate())

		SET @V_Id = @@IDENTITY;

--Associating same projects to new scenario for duplication

INSERT INTO ScenarioProjectMapper (ScenarioID,ProjectID,CreatedBy,CreatedAt)
SELECT @V_Id,spm.ProjectID,@P_CreatedBy,GETDATE() FROM ScenarioProjectMapper spm
left join Project p on  spm.ProjectId = p.ProjectId 
WHERE spm.ScenarioID=@P_ScenarioID and p.ProjectStatus = 'Active';
	
--Duplicating ScenarioData 

If (@P_FinancialYear <> @V_FinancialYear)

INSERT INTO [dbo].[ScenarioData]
           ([ScenarioID],[ProjectID],[ScenarioDataTypeID],[Year],[Q1New],[Q1Variant],[Q2New],[Q2Variant],[Q3New],[Q3Variant],[Q4New],[Q4Variant],[CreatedBy],[CreatedAt]
           ) Select @V_Id,[ProjectID],[ScenarioDataTypeID],[Year],[Q1New],[Q1Variant],[Q2New],[Q2Variant],[Q3New],[Q3Variant],[Q4New],[Q4Variant],@P_CreatedBy,getdate()
		   from ScenarioData where ScenarioID=@P_ScenarioID and [Year] >=@P_FinancialYear ;
else

INSERT INTO [dbo].[ScenarioData] ([ScenarioID],[ProjectID],[ScenarioDataTypeID],[Year],[Q1New],[Q1Variant],[Q2New],[Q2Variant],[Q3New],[Q3Variant],[Q4New],[Q4Variant],[CreatedBy],[CreatedAt]
           ) Select  @V_Id,[ProjectID],[ScenarioDataTypeID],[Year],[Q1New],[Q1Variant],[Q2New],[Q2Variant],[Q3New],[Q3Variant],[Q4New],[Q4Variant],@P_CreatedBy,getdate() 
			from ScenarioData where ScenarioID=@P_ScenarioID;

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
	
	SET @V_LogDescription = CONCAT(@ScenarioName , ' ==> ' , @V_ScenarioName);
	 Exec LogActivity 'ScenarioDuplication',' ',@P_ScenarioId,@V_LogDescription,@P_CreatedBy;

End;	
END
SET @V_Message = (SELECT [Message] FROM dbo.[Messages] WHERE MessageCode = @V_MessageCode);
SELECT @V_Message,@V_Id,@V_ScenarioName ScenarioName ;
End