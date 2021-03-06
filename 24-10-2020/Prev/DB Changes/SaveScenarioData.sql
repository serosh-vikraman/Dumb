
ALTER PROCEDURE [dbo].[SaveScenarioData] @XMLData XML
AS
BEGIN

DECLARE @i INT = 1;
DECLARE @Count INT = @XMLData.value('count(/TDS/TD)', 'int');
DECLARE @ScenarioID int;
DECLARE @ProjectID int;
DECLARE @ScenarioDataTypeID int; 
DECLARE @Year int;
DECLARE @Q1New DECIMAL(10, 3);
DECLARE @Q1Variant  DECIMAL(10, 3);
DECLARE @Q2New  DECIMAL(10, 3);
DECLARE @Q2Variant  DECIMAL(10, 3);
DECLARE @Q3New  DECIMAL(10, 3);
DECLARE @Q3Variant  DECIMAL(10, 3);
DECLARE @Q4New  DECIMAL(10, 3);
DECLARE @Q4Variant  DECIMAL(10, 3);
DECLARE @UploadSessionID varchar(500);
DECLARE @CreatedBy varchar(20);
DECLARE @V_Count INT;
Declare @SubAction varchar(50);
Declare @V_Description varchar(2000);
DECLARE @V_Lock bit;


WHILE @i <= @Count
		BEGIN	

	SET @ScenarioID = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS int);
	SET @ProjectID=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ProjectID/text())[1]', 'int') AS int);
	SET @ScenarioDataTypeID= cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ScenarioDataTypeID/text())[1]', 'int') AS int);
  	SET @Year=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Year/text())[1]', 'int') AS int);
    SET @Q1New=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q1New/text())[1]', 'DECIMAL(10, 3)') AS decimal);
	SET @Q1Variant= cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q1Variant/text())[1]', 'DECIMAL(10, 3)') AS decimal);
  	SET @Q2New=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q2New/text())[1]', 'DECIMAL(10, 3)') AS decimal);
	SET @Q2Variant = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q2Variant/text())[1]', 'DECIMAL(10, 3)') AS decimal);
	SET @Q3New=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q3New/text())[1]', 'DECIMAL(10, 3)') AS decimal);
	SET @Q3Variant= cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q3Variant/text())[1]', 'DECIMAL(10, 3)') AS decimal);
  	SET @Q4New=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q4New/text())[1]', 'DECIMAL(10, 3)') AS decimal);
	SET @Q4Variant = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q4Variant/text())[1]', 'DECIMAL(10, 3)') AS decimal);
	--SET @UploadSessionID=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/UploadSessionID/text())[1]', 'varchar(500)') AS varchar);
	SET @CreatedBy=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(20)') AS varchar(20));

	Select @V_Count = count(1) from ScenarioData where ProjectID=@ProjectID and ScenarioDataTypeID=@ScenarioDataTypeID and [Year]=@Year and ScenarioID=@ScenarioID;
	Select @V_Lock = ScenarioLock from Scenario where ScenarioID=@ScenarioID;
	If (@V_Count=0 and @V_Lock=0)
	begin
INSERT INTO [dbo].[ScenarioData]
           ([ScenarioID]
           ,[ProjectID]
           ,[ScenarioDataTypeID]
           ,[Year]
           ,[Q1New]
           ,[Q1Variant]
           ,[Q2New]
           ,[Q2Variant]
           ,[Q3New]
           ,[Q3Variant]
           ,[Q4New]
           ,[Q4Variant]
           ,[CreatedBy]
           ,[CreatedAt]
           )
     VALUES
           (@ScenarioID
           ,@ProjectID
           ,@ScenarioDataTypeID
           ,@Year
           ,@Q1New
           ,@Q1Variant
           ,@Q2New
           ,@Q2Variant
           ,@Q3New
           ,@Q3Variant
           ,@Q4New
		   ,@Q4Variant
           ,@CreatedBy
           ,getdate()
           );
		   SET @SubAction='Save';

		    end
		   else
		   begin
		   

UPDATE [dbo].[ScenarioData]
   SET 
       [Q1New] = @Q1New
      ,[Q1Variant] = @Q1Variant
      ,[Q2New] = @Q2New
      ,[Q2Variant] = @Q2Variant
      ,[Q3New] = @Q3New
      ,[Q3Variant] = @Q3Variant
      ,[Q4New] = @Q4New
      ,[Q4Variant] = @Q4Variant      
      ,[UpdatedBy] = @CreatedBy
      ,[UpdatedAt] = getdate()
      
       WHERE ProjectID=@ProjectID and ScenarioDataTypeID=@ScenarioDataTypeID and [Year]=@Year and ScenarioID=@ScenarioID;

	   SET @SubAction='Update';
      end
	  SET @V_Description =Concat( 'ProjectID = ', @ProjectID , ' and ScenarioDataTypeID = ' , @ScenarioDataTypeID , ' and Year = ' , @Year , ' and ScenarioID = ' , @ScenarioID);

	  Exec LogActivity 'ScenarioData',@SubAction,0,@V_Description,@CreatedBy;

  SET @i = @i + 1;
 
END



End;