
ALTER PROCEDURE [dbo].[UploadProjectScenarioDataType_1_New] @P_Xml XML
	,@P_ActiveQuarters VARCHAR(20)
AS
BEGIN
	DECLARE @Count INT = @P_Xml.value('count(/ScenarioDatas/ScenarioData)', 'int');
	DECLARE @i INT = 1;
	DECLARE @V_DataId INT

	WHILE @i <= @Count
	BEGIN
		SET @V_DataId = (
				SELECT Id
				FROM ScenarioData
				WHERE ScenarioID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT)
					AND ScenarioDataTypeID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT)
					AND [Year] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'int') AS INT)
					AND ProjectID =cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectID/text())[1]', 'int') AS INT)
				);
				select @V_DataId;
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
			IF @P_ActiveQuarters LIKE '%Q1%'
				UPDATE [dbo].[ScenarioData]
				SET [Q1New] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q1New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
					,[UpdatedBy] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(50)') AS VARCHAR(50))
					,[UpdatedAt] = GETDATE()
					,[UploadSessionIdQ1] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
				WHERE ScenarioID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT)
					AND ScenarioDataTypeID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT)
					AND [Year] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'int') AS INT)
					AND ProjectID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectId/text())[1]', 'int') AS INT);

			IF @P_ActiveQuarters LIKE '%Q2%'
				UPDATE [dbo].[ScenarioData]
				SET [Q1New] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q2New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
					,[UpdatedBy] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(50)') AS VARCHAR(50))
					,[UpdatedAt] = GETDATE()
					,[UploadSessionIdQ1] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
				WHERE ScenarioID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT)
					AND ScenarioDataTypeID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT)
					AND [Year] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'int') AS INT)
					AND ProjectID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectId/text())[1]', 'int') AS INT);

			IF @P_ActiveQuarters LIKE '%Q3%'
				UPDATE [dbo].[ScenarioData]
				SET [Q1New] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q3New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
					,[UpdatedBy] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(50)') AS VARCHAR(50))
					,[UpdatedAt] = GETDATE()
					,[UploadSessionIdQ1] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
				WHERE ScenarioID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT)
					AND ScenarioDataTypeID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT)
					AND [Year] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'int') AS INT)
					AND ProjectID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectId/text())[1]', 'int') AS INT);

			IF @P_ActiveQuarters LIKE '%Q4%'
				UPDATE [dbo].[ScenarioData]
				SET [Q1New] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Q4New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL(10, 3))
					,[UpdatedBy] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(50)') AS VARCHAR(50))
					,[UpdatedAt] = GETDATE()
					,[UploadSessionIdQ1] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/UploadSessionId/text())[1]', 'varchar(500)') AS VARCHAR(500))
				WHERE ScenarioID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT)
					AND ScenarioDataTypeID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ScenarioDataTypeId/text())[1]', 'int') AS INT)
					AND [Year] = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/Year/text())[1]', 'int') AS INT)
					AND ProjectID = cast(@P_Xml.value('(/ScenarioDatas/ScenarioData[sql:variable("@i")]/ProjectId/text())[1]', 'int') AS INT);
		END;
		SET @i = @i + 1;
	END;
END;
