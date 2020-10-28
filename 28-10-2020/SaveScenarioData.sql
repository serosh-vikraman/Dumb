ALTER PROCEDURE [dbo].[SaveScenarioData] @XMLData XML
AS
BEGIN
	DECLARE @i INT = 1;
	DECLARE @Count INT = @XMLData.value('count(/TDS/TD)', 'int');
	DECLARE @ScenarioID INT;
	DECLARE @ProjectID INT;
	DECLARE @ScenarioDataTypeID INT;
	DECLARE @Year INT;
	DECLARE @Q1New DECIMAL(10, 3);
	DECLARE @Q1Variant DECIMAL(10, 3);
	DECLARE @Q2New DECIMAL(10, 3);
	DECLARE @Q2Variant DECIMAL(10, 3);
	DECLARE @Q3New DECIMAL(10, 3);
	DECLARE @Q3Variant DECIMAL(10, 3);
	DECLARE @Q4New DECIMAL(10, 3);
	DECLARE @Q4Variant DECIMAL(10, 3);
	DECLARE @UploadSessionID VARCHAR(500);
	DECLARE @CreatedBy VARCHAR(20);
	DECLARE @V_Count INT;
	DECLARE @SubAction VARCHAR(50);
	DECLARE @V_Description VARCHAR(2000);
	DECLARE @V_Lock BIT;


	SET @V_Lock = (
			SELECT ScenarioLock
			FROM Scenario
			WHERE ScenarioID = 179
			);

	IF (@V_Lock = 0)
	BEGIN
		WHILE @i <= @Count
		BEGIN
			SET @ScenarioID = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT);
			SET @ProjectID = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ProjectID/text())[1]', 'int') AS INT);
			SET @ScenarioDataTypeID = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ScenarioDataTypeID/text())[1]', 'int') AS INT);
			SET @Year = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Year/text())[1]', 'int') AS INT);
			SET @Q1New = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q1New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL);
			SET @Q1Variant = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q1Variant/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL);
			SET @Q2New = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q2New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL);
			SET @Q2Variant = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q2Variant/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL);
			SET @Q3New = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q3New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL);
			SET @Q3Variant = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q3Variant/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL);
			SET @Q4New = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q4New/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL);
			SET @Q4Variant = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/Q4Variant/text())[1]', 'DECIMAL(10, 3)') AS DECIMAL);
			--SET @UploadSessionID=cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/UploadSessionID/text())[1]', 'varchar(500)') AS varchar);
			SET @CreatedBy = cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/CreatedBy/text())[1]', 'varchar(20)') AS VARCHAR(20));
			SET @V_Count = (
					SELECT Id
					FROM ScenarioData
					WHERE ProjectID = @ProjectID
						AND ScenarioDataTypeID = @ScenarioDataTypeID
						AND [Year] = @Year
						AND ScenarioID = @ScenarioID
					);

			IF (@V_Count IS NULL)
			BEGIN
				INSERT INTO [dbo].[ScenarioData] (
					[ScenarioID]
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
				VALUES (
					@ScenarioID
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

				SET @SubAction = 'Save';
			END
			ELSE
			BEGIN
				UPDATE [dbo].[ScenarioData]
				SET [Q1New] = @Q1New
					,[Q1Variant] = @Q1Variant
					,[Q2New] = @Q2New
					,[Q2Variant] = @Q2Variant
					,[Q3New] = @Q3New
					,[Q3Variant] = @Q3Variant
					,[Q4New] = @Q4New
					,[Q4Variant] = @Q4Variant
					,[UpdatedBy] = @CreatedBy
					,[UpdatedAt] = getdate()
				WHERE Id = @V_Count;

				SET @SubAction = 'Update';
			END

			SET @V_Description = CONCAT (
					'ProjectID = '
					,@ProjectID
					,' and ScenarioDataTypeID = '
					,@ScenarioDataTypeID
					,' and Year = '
					,@Year
					,' and ScenarioID = '
					,@ScenarioID
					);

			EXEC LogActivity 'ScenarioData'
				,@SubAction
				,0
				,@V_Description
				,@CreatedBy;

			SET @i = @i + 1;
		END
	END;
END;