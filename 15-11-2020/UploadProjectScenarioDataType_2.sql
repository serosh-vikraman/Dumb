ALTER PROCEDURE [dbo].[UploadProjectScenarioDataType_2_New] @P_ActiveQuarter VARCHAR(8)
	,@P_Xml XML
AS
BEGIN
	DECLARE @Count INT = @P_Xml.value('count(/ScenarioDatas/ScenarioData)', 'int');
	DECLARE @i INT = 1;
	DECLARE @ScenarioDataExists INT = 0;
	DECLARE @Q1Data DECIMAL(10,3);
	DECLARE @Q2Data DECIMAL(10, 3);
	DECLARE @Q3Data DECIMAL(10, 3);
	DECLARE @Q4Data DECIMAL(10, 3);
	DECLARE @ProjectId INT;
	DECLARE @Year INT;
	DECLARE @ScenarioId INT;
	DECLARE @ScenarioDataTypeId INT = 0;
	DECLARE @UploadSessionIdQ1 VARCHAR(500) = NULL;
	DECLARE @UploadSessionIdQ2 VARCHAR(500) = NULL;
	DECLARE @UploadSessionIdQ3 VARCHAR(500) = NULL;
	DECLARE @UploadSessionIdQ4 VARCHAR(500) = NULL;
	DECLARE @V_ProjectCode VARCHAR(50);
	DECLARE @V_ScenarioId INT;
	DECLARE @V_CreatedBy VARCHAR(500);
	DECLARE @V_ScenarioProjectLogId INT;
	DECLARE @V_LogDescription VARCHAR(4000);

	WHILE @i <= @Count
	BEGIN
		SET @ProjectId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectID/text())[1]', 'INT') AS INT);
		SET @Year = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'INT') AS INT);
		SET @ScenarioId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'INT') AS INT);
		SET @ScenarioDataTypeId = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT);

		IF @P_ActiveQuarter = 'Q1'
			SET @UploadSessionIdQ1 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'VARCHAR(500)') AS VARCHAR(500));
		ELSE IF @P_ActiveQuarter = 'Q2'
			SET @UploadSessionIdQ2 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'VARCHAR(500)') AS VARCHAR(500));
		ELSE IF @P_ActiveQuarter = 'Q3'
			SET @UploadSessionIdQ3 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'VARCHAR(500)') AS VARCHAR(500));
		ELSE IF @P_ActiveQuarter = 'Q4'
			SET @UploadSessionIdQ4 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'VARCHAR(500)') AS VARCHAR(500));
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

		IF (@i = 1)
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
		END;

		SET @ScenarioDataExists = (
				SELECT Id
				FROM ScenarioData
				WHERE ProjectID = @ProjectId
					AND ScenarioID = @ScenarioId
					AND ScenarioDataTypeID = @ScenarioDataTypeId
					AND [Year] = @Year
				);

		IF @ScenarioDataExists IS NULL
		BEGIN
			INSERT INTO [dbo].[ScenarioData] (
				[ScenarioID]
				,[ProjectID]
				,[ScenarioDataTypeId]
				,[Year]
				,[Q1New]
				,[Q2New]
				,[Q3New]
				,[Q4New]
				,[UploadSessionIdQ1]
				,[UploadSessionIdQ2]
				,[UploadSessionIdQ3]
				,[UploadSessionIdQ4]
				,[CreatedBy]
				,[CreatedAt]
				)
			VALUES (
				@ScenarioId
				,@ProjectId
				,@ScenarioDataTypeId
				,@Year
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q1New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q2New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q3New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q4New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
				,@UploadSessionIdQ1
				,@UploadSessionIdQ2
				,@UploadSessionIdQ3
				,@UploadSessionIdQ4
				,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/CreatedBy/text())[1]', 'VARCHAR(50)') AS VARCHAR(50))
				,GETDATE()
				);
		END;
		ELSE
		BEGIN
			IF @P_ActiveQuarter = 'Q1'
			BEGIN
			SET @Q1Data = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q1New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3));

				IF (@Q1Data IS NOT NULL)
					UPDATE ScenarioData
					SET Q1New = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q1New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
						,UploadSessionIdQ1 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
					WHERE Id = @ScenarioDataExists;
			END;

			IF @P_ActiveQuarter = 'Q2'
			BEGIN
				SET @Q2Data = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q2New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3));

				IF (@Q2Data IS NOT NULL)
					UPDATE ScenarioData
					SET Q2New = @Q2Data - ISNULL(Q1New, 0)
						,UploadSessionIdQ2 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
					WHERE Id = @ScenarioDataExists;
			END;

			IF @P_ActiveQuarter = 'Q3'
			BEGIN
				SET @Q3Data = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q3New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3));

				IF (@Q3Data IS NOT NULL)
					UPDATE ScenarioData
					SET Q3New = @Q3Data - (ISNULL(Q1New, 0) + ISNULL(Q2New, 0))
						,UploadSessionIdQ3 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
					WHERE Id = @ScenarioDataExists;
			END;

			IF @P_ActiveQuarter = 'Q4'
			BEGIN
				SET @Q4Data = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q4New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3));

				IF (@Q4Data IS NOT NULL)
					UPDATE ScenarioData
					SET Q4New = @Q4Data - (ISNULL(Q1New, 0) + ISNULL(Q2New, 0) + ISNULL(Q3New, 0))
						,UploadSessionIdQ4 = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
					WHERE Id = @ScenarioDataExists;
			END;
		END;

		INSERT INTO [dbo].[ScenarioUploadLog] (
			[ScenarioID]
			,[UploadSessionID]
			,[ProjectCode]
			,[RowNumber]
			,[UploadStatus]
			,[CreatedBy]
			,[CreatedAt]
			,[UploadDescription]
			)
		VALUES (
			@V_ScenarioId
			,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'VARCHAR(500)') AS VARCHAR(500))
			,@V_ProjectCode
			,cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/RowNumber/text())[1]', 'int') AS INT)
			,1
			,@V_CreatedBy
			,GetDate()
			,'Project Uploaded Successfully.'
			);

		SET @i = @i + 1;
	END;

	DELETE
	FROM ScenarioProjectLog
	WHERE ScenarioProjectLogId = @V_ScenarioProjectLogId;
END;