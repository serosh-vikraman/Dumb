
ALTER PROCEDURE [dbo].[UploadProjectScenarioDataType_1_New] @P_Xml XML
	,@P_ActiveQuarters VARCHAR(20)
AS
BEGIN
	DECLARE @Count INT = @P_Xml.value('count(/ScenarioDatas/ScenarioData)', 'int');
	DECLARE @i INT = 1;
	DECLARE @V_DataId INT;
	DECLARE @V_ScenarioId INT;
	DECLARE @V_CreatedBy VARCHAR(500);
	DECLARE @V_ScenarioProjectLogId INT;
	DECLARE @V_UploadSessionId VARCHAR(500);
	DECLARE @V_ProjectCode VARCHAR(50);
	DECLARE @V_LogMessage VARCHAR(50);
	DECLARE @U_ScenarioId INT;
	DECLARE @U_ScenarioDataTypeId INT;
	DECLARE @U_ProjectId INT;
	DECLARE @U_Year INT;
	DECLARE @U_Q1 decimal(10,3);
	DECLARE @U_Q2 decimal(10,3);
	DECLARE @U_Q3 decimal(10,3);
	DECLARE @U_Q4 decimal(10,3);
	DECLARE @U_UpdatedBy VARCHAR(50);
	DECLARE @U_UploadSessionId VARCHAR(500);

	WHILE @i <= @Count
	BEGIN
	
		IF @i = 1
			SET @V_UploadSessionId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500));
		SET @V_DataId = (
				SELECT Id
				FROM ScenarioData
				WHERE ScenarioID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT)
					AND ScenarioDataTypeID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT)
					AND [Year] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'int') AS INT)
					AND ProjectID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectID/text())[1]', 'int') AS INT)
				);

		SELECT @V_DataId;

		IF @i = 1
		BEGIN
			SET @V_ScenarioId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT);
			SET @V_CreatedBy = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(50)') AS VARCHAR(50));

			INSERT INTO ScenarioProjectLog (
				ScenarioId
				,ProjectId
				,CreatedBy
				,CreatedAt
				,[Status]
				)
			VALUES (
				@V_ScenarioId
				,0
				,@V_CreatedBy
				,GETDATE()
				,0
				);

			SELECT @V_ScenarioProjectLogId = @@IDENTITY;
				-- set @V_ScenarioProjectLogId=0;
		END;

		SET @V_ProjectCode = (
				SELECT IFSProjectCode
				FROM Project
				WHERE ProjectId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectID/text())[1]', 'int') AS INT)
				);

		IF @V_ProjectCode IS NULL
			SET @V_ProjectCode = (
					SELECT ManualProjectCode
					FROM Project
					WHERE ProjectId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectID/text())[1]', 'int') AS INT)
					);
    SET @U_ScenarioId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT);
	SET @U_ScenarioDataTypeId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT);
	SET @U_ProjectId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectID/text())[1]', 'int') AS INT);
	SET @U_Year = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'int') AS INT);
	SET @U_Q1 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q1New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3));
	SET @U_Q2 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q2New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3));
	SET @U_Q3 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q3New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3));
	SET @U_Q4 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q4New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3));
	SET @U_UpdatedBy = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(50)') AS VARCHAR(50))
	SET @U_UploadSessionId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))

		IF @V_DataId IS NULL
			INSERT INTO [dbo].[ScenarioData] (
				[ScenarioID]
				,[ProjectID]
				,[ScenarioDataTypeID]
				,[Year]
				,[Q1New]
				,[Q2New]
				,[Q3New]
				,[Q4New]
				,[UploadSessionIdQ1]
				,[CreatedBy]
				,[CreatedAt]
				)
			VALUES (
				cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT)
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectID/text())[1]', 'int') AS INT)
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT)
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'int') AS INT)
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q1New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q2New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q3New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q4New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(50)') AS VARCHAR(50))
				,GETDATE()
				);
		ELSE
		BEGIN
		--SET @V_LogMessage = CONCAT(@U_ScenarioId,',',@U_ScenarioDataTypeId,',',@U_ProjectId,',',@U_Year,',',@U_Q1,',',@U_Q2,',',@U_Q3,',',@U_Q4);
	    --exec InsertLog @V_LogMessage;
			
				UPDATE [dbo].[ScenarioData]
				SET [Q1New] = @U_Q1
					,[UpdatedBy] = @U_UpdatedBy
					,[UpdatedAt] = GETDATE()
					,[UploadSessionIdQ1] = @U_UploadSessionId
				WHERE ScenarioID = @U_ScenarioId
					AND ScenarioDataTypeID = @U_ScenarioDataTypeId
					AND [Year] = @U_Year
					AND ProjectID = @U_ProjectId
					AND 0=(Select Count(1) from LockQuarter Where [Year] = @U_Year and [Quarter] = 'Q1' and ISNULL(Lock,0) = 1) ;				

			
				UPDATE [dbo].[ScenarioData]
				SET [Q2New] = @U_Q2
					,[UpdatedBy] = @U_UpdatedBy
					,[UpdatedAt] = GETDATE()
					,[UploadSessionIdQ1] = @U_UploadSessionId
				WHERE ScenarioID = @U_ScenarioId
					AND ScenarioDataTypeID = @U_ScenarioDataTypeId
					AND [Year] = @U_Year
					AND ProjectID = @U_ProjectId
					AND 0=(Select Count(1) from LockQuarter Where [Year] = @U_Year and [Quarter] = 'Q2' and ISNULL(Lock,0) = 1) ;

				UPDATE [dbo].[ScenarioData]
				SET [Q3New] = @U_Q3
					,[UpdatedBy] = @U_UpdatedBy
					,[UpdatedAt] = GETDATE()
					,[UploadSessionIdQ1] = @U_UploadSessionId
				WHERE ScenarioID = @U_ScenarioId
					AND ScenarioDataTypeID = @U_ScenarioDataTypeId
					AND [Year] = @U_Year
					AND ProjectID = @U_ProjectId
					AND 0=(Select Count(1) from LockQuarter Where [Year] = @U_Year and [Quarter] = 'Q3' and ISNULL(Lock,0) = 1) ;
			
				UPDATE [dbo].[ScenarioData]
				SET [Q4New] = @U_Q4
					,[UpdatedBy] = @U_UpdatedBy
					,[UpdatedAt] = GETDATE()
					,[UploadSessionIdQ1] = @U_UploadSessionId
				WHERE ScenarioID = @U_ScenarioId
					AND ScenarioDataTypeID = @U_ScenarioDataTypeId
					AND [Year] = @U_Year
					AND ProjectID = @U_ProjectId
					AND 0=(Select Count(1) from LockQuarter Where [Year] = @U_Year and [Quarter] = 'Q4' and ISNULL(Lock,0) = 1) ;;
		END;

		INSERT INTO [dbo].[ScenarioUploadLog] (
			[ScenarioID]
			,[UploadSessionID]
			,[ProjectCode]
			,[RowNumber]
			,[UploadStatus]
			,[CreatedBy]
			,[CreatedAt]
			)
		VALUES (
			@V_ScenarioId
			,@V_UploadSessionId
			,@V_ProjectCode
			,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/RowNumber/text())[1]', 'int') AS INT)
			,1
			,@V_CreatedBy
			,GetDate()
			);

		SET @i = @i + 1;
	END;

	/*UPDATE ScenarioProjectLog
	SET [Status] = 1
	WHERE ScenarioProjectLogId = @V_ScenarioProjectLogId;*/
	  DELETE FROM ScenarioProjectLog where ScenarioProjectLogId=@V_ScenarioProjectLogId;
END;