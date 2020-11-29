
 

CREATE PROCEDURE [dbo].[BulkProjectUpload] @P_TempXml XML,@P_ErrorXml XML 
AS
BEGIN
Declare @V_Id int;
Declare @V_SubAction varchar(100);
Declare @V_Name varchar(50);
Declare @V_Code varchar(5);
Declare @V_Active bit;
Declare @V_LogDescription varchar(500) ;


DECLARE @ErrorCount INT = @P_ErrorXml.value('count(/Logs/Log)', 'int');
DECLARE @i INT = 1;

DECLARE @Count INT = @P_TempXml.value('count(/Projects/Project)', 'int');
DECLARE @j INT = 1;

 
Declare @SessionId   varchar(250);
Declare @RowNum   int;
Declare @IFSProjectCode   varchar(15);
Declare @ManualProjectCode   varchar(15);
Declare @ProjectName   varchar(250);
Declare @ProjectSegmentName   varchar(50);
Declare @ProjectEntityName   varchar(500);
Declare @BUCategoryName   varchar(500);
Declare @StatutoryCategoryName   varchar(500);
Declare @CountryName   varchar(500);
Declare @BillingTypesName   varchar(500);
Declare @ContractTypeName   varchar(500);
Declare @ContractStatusName   varchar(500);
Declare @SmartViewName   varchar(500);
Declare @GroupingParametersName   varchar(500);
Declare @ManagementCategoryName   varchar(500);
Declare @ClubbingParamName   varchar(500);
Declare @ProjectSegmentCode   varchar(5);
Declare @ProjectEntityCode   varchar(5);
Declare @BUCategoryCode   varchar(5);
Declare @StatutoryCategoryCode   varchar(5);
Declare @CountryCode   varchar(5);
Declare @BillingTypesCode   varchar(5);
Declare @ContractTypeCode   varchar(5);
Declare @ContractStatusCode   varchar(5);
Declare @SmartViewCode   varchar(5);
Declare @GroupingParametersCode   varchar(5);
Declare @ManagementCategoryCode   varchar(5);
Declare @ClubbingParamCode   varchar(5);
Declare @Notes   varchar(3000);
Declare @Message   varchar(3000);
Declare @CreatedBy   varchar(50);
Declare @StatusText   varchar(50);
Declare @RecordStatus   varchar(50);

	BEGIN
 WHILE @j <= @Count

 			BEGIN

			SET @SessionId =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/SessionId/text())[1]', 'varchar(250)') AS VARCHAR(250));
SET @RowNum   =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/RowNum/text())[1]', 'int') AS int);;
SET @IFSProjectCode  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/IFSProjectCode/text())[1]', 'varchar(250)') AS VARCHAR(250));
SET @ManualProjectCode  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ManualProjectCode/text())[1]', 'varchar(250)') AS VARCHAR(250));
SET @ProjectName   =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ProjectName/text())[1]', 'varchar(250)') AS VARCHAR(250));
SET @ProjectSegmentName  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ProjectSegmentName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @ProjectEntityName  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ProjectEntityName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @BUCategoryName   =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/BUCategoryName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @StatutoryCategoryName  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/StatutoryCategoryName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @CountryName  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/CountryName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @BillingTypesName  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/BillingTypesName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @ContractTypeName   =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ContractTypeName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @ContractStatusName  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ContractStatusName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @SmartViewName   =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/SmartViewName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @GroupingParametersName   =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/GroupingParametersName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @ManagementCategoryName   =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ManagementCategoryName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @ClubbingParamName   =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ClubbingParameterName/text())[1]', 'varchar(500)') AS VARCHAR(500));
SET @ProjectSegmentCode  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ProjectSegmentCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @ProjectEntityCode  = cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ProjectEntityCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @BUCategoryCode   =cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/BUCategoryCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @StatutoryCategoryCode =   cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/StatutoryCategoryCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @CountryCode  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/CountryCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @BillingTypesCode   =cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/BillingTypesCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @ContractTypeCode  = cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ContractTypeCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @ContractStatusCode =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ContractStatusCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @SmartViewCode    =cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/SmartViewCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @GroupingParametersCode  =cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/GroupingParametersCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @ManagementCategoryCode  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ManagementCategoryCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @ClubbingParamCode  =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/ClubbingParameterCode/text())[1]', 'varchar(5)') AS VARCHAR(5));
SET @Notes = cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/Notes/text())[1]', 'varchar(3000)') AS VARCHAR(3000));
SET @Message =  cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/Message/text())[1]', 'varchar(3000)') AS VARCHAR(3000));
SET @CreatedBy  = cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/UserName/text())[1]', 'varchar(50)') AS VARCHAR(50));
SET @StatusText  = cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/Status/text())[1]', 'varchar(50)') AS VARCHAR(50));
 SET @RecordStatus  = cast(@P_TempXml.value('(/Projects/Project[sql:variable("@j")]/RecordStatus/text())[1]', 'varchar(50)') AS VARCHAR(50));
INSERT INTO [dbo].[TempProject]
           ([SessionId]
           ,[RowNum]
           ,[IFSProjectCode]
           ,[ManualProjectCode]
           ,[ProjectName]
           ,[ProjectSegmentName]
           ,[ProjectEntityName]
           ,[BUCategoryName]
           ,[StatutoryCategoryName]
           ,[CountryName]
           ,[BillingTypesName]
           ,[ContractTypeName]
           ,[ContractStatusName]
           ,[SmartViewName]
           ,[GroupingParametersName]
           ,[ManagementCategoryName]
		   ,ClubbingParameterName
           ,[ProjectSegmentCode]
           ,[ProjectEntityCode]
           ,[BUCategoryCode]
           ,[StatutoryCategoryCode]
           ,[CountryCode]
           ,[BillingTypesCode]
           ,[ContractTypeCode]
           ,[ContractStatusCode]
           ,[SmartViewCode]
           ,[GroupingParametersCode]
           ,[ManagementCategoryCode]
		   ,ClubbingParameterCode
           ,[Notes]
           ,[Message]
		   ,ProjectStatus
           ,[CreatedBy]
           ,[CreatedAt])
     VALUES
           (@SessionId
            ,@RowNum
			 ,@IFSProjectCode
           ,@ManualProjectCode
           ,@ProjectName
           ,@ProjectSegmentName
           ,@ProjectEntityName
           ,@BUCategoryName
           ,@StatutoryCategoryName
           ,@CountryName
           ,@BillingTypesName
           ,@ContractTypeName
           ,@ContractStatusName
           ,@SmartViewName
           ,@GroupingParametersName
           ,@ManagementCategoryName
		   ,@ClubbingParamName
           ,@ProjectSegmentCode
           ,@ProjectEntityCode
           ,@BUCategoryCode
           ,@StatutoryCategoryCode
           ,@CountryCode
           ,@BillingTypesCode
           ,@ContractTypeCode
           ,@ContractStatusCode
           ,@SmartViewCode
           ,@GroupingParametersCode
           ,@ManagementCategoryCode
		   ,@ClubbingParamCode
           ,@Notes
           ,@Message
		   ,@StatusText
           ,@CreatedBy
           ,GETDATE());

		   IF @RecordStatus='OK'
		   BEGIN

	 

INSERT INTO [dbo].[Project]
           ([ProjectType]
           ,[IFSProjectCode]
           ,[ManualProjectCode]
           ,[ProjectName]
           ,[ProjectSegmentCode]
           ,[ProjectEntityCode]
           ,[BUCategoryCode]
           ,[StatutoryCategoryCode]
           ,[CountryCode]
           ,[BillingTypesCode]
           ,[ContractTypeCode]
           ,[ContractStatusCode]
           ,[SmartViewCode]
           ,[GroupingParametersCode]
           ,[ManagementCategoryCode]
		   ,[ClubbingParameterCode]
           ,[Notes]
           ,[ProjectStatus]
           ,[CreatedBy]
           ,[CreatedAt]
           ,[UpdatedBy]
           ,[UpdatedAt])
     VALUES
           ('Manual'
           ,@IFSProjectCode
           ,@ManualProjectCode
           ,@ProjectName
          ,@ProjectSegmentCode
           ,@ProjectEntityCode
           ,@BUCategoryCode
           ,@StatutoryCategoryCode
           ,@CountryCode
           ,@BillingTypesCode
           ,@ContractTypeCode
           ,@ContractStatusCode
           ,@SmartViewCode
           ,@GroupingParametersCode
           ,@ManagementCategoryCode
		   ,@ClubbingParamCode
           ,@Notes
           ,@StatusText
           ,@CreatedBy
           ,GETDATE()
           ,@CreatedBy
           ,GETDATE());
  

		   END;

		   SET @j = @j + 1;
END;



		WHILE @i <= @ErrorCount
			BEGIN
				INSERT INTO [dbo].[ProjectUploadLog]
								([SessionID]
								,[RowNumber]
								,[ColumnNumber]
								,[Status]
								,[Message]
								,[CreatedBy]
								,[CreatedAt]
								,[ErrorCode])
						 VALUES
								(cast(@P_ErrorXml.value('(/Logs/Log[sql:variable("@i")]/SessionID/text())[1]', 'varchar(250)') AS VARCHAR(250))
								,cast(@P_ErrorXml.value('(/Logs/Log[sql:variable("@i")]/RowNumber/text())[1]', 'int') AS int)
								,cast(@P_ErrorXml.value('(/Logs/Log[sql:variable("@i")]/ColumnNumber/text())[1]', 'int') AS int)
								,''
								,cast(@P_ErrorXml.value('(/Logs/Log[sql:variable("@i")]/Message/text())[1]', 'varchar(2500)') AS VARCHAR(2500))
								,cast(@P_ErrorXml.value('(/Logs/Log[sql:variable("@i")]/UserName/text())[1]', 'varchar(250)') AS VARCHAR(250))
								,GETDATE()
								,cast(@P_ErrorXml.value('(/Logs/Log[sql:variable("@i")]/ErrorCode/text())[1]', 'varchar(25)') AS VARCHAR(250)));
						 SET @i = @i + 1;
		END;

  Exec LogActivity 'BulkProjectUpload','','','',@CreatedBy;
  
 
		END;
 
END;
GO


