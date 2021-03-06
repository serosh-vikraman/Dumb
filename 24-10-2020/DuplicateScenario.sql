

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
	DECLARE @V_Message       VARCHAR(200)='Success';
	DECLARE @CountBD INT;
	DECLARE @V_Lock   bit;

	SELECT  @V_ScenarioTypeCode= ScenarioTypeCode ,@V_FinancialYear = FinancialYear  from Scenario where ScenarioID = @P_ScenarioId;	

	If ((@V_FinancialYear = @P_FinancialYear) or (@V_ScenarioTypeCode = 'FC' and @P_FinancialYear = @V_FinancialYear+1))  --Check if Financial Year is same  

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
                        SET @V_Message ='Budget for this year not locked'; 
			           end;
			        End;
			    else
			    begin
			      SET @isSuccess=0;
                  SET @V_Message ='Budget for this year and scope not created' 		
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
               SET @V_Message ='Only one Budget allowed in Year.' 		
		 end;
		 -- return if trying to create more than 4 actuals
		If (@V_Count > 4 and @P_ScenarioTypeCode='AC' ) 
		begin 
		SET @isSuccess=0; 		
        SET @V_Message ='Maximum of Four Actuals already entered.' 		
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
	
	
	 Exec LogActivity 'ScenarioDuplication',' ',@P_ScenarioId,' ',@P_CreatedBy;

End;	
END
else 
begin
Set @V_Id = 0;
SET @V_Message ='Budget and Actual Scenario cannot be duplicated to next year and Forecast Scenarios can only be duplicated to the consecutive year.' 
end;
SELECT @V_Message,@V_Id,@V_ScenarioName ScenarioName ;
End