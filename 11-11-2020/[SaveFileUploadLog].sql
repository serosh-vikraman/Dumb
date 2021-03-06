ALTER PROCEDURE [dbo].[SaveFileUploadLog] @P_Xml XML
AS
BEGIN
	DECLARE @Count INT = @P_Xml.value('count(/FileUploadLog/Log)', 'int');
	DECLARE @i INT = 1;

	WHILE @i <= @Count
	BEGIN
		INSERT INTO [dbo].[ScenarioUploadLog] (
			[ScenarioID]
			,[ProjectCode]
			,[UploadSessionId]
			,[UploadDescription]
			,[RowNumber]
			,[CreatedBy]
			,[CreatedAt]
			,[UploadStatus]
			,[ColumnNumber]
			)
		VALUES (
			cast(@P_Xml.value('(/FileUploadLog/Log[sql:variable("@i")]/ScenarioID/text())[1]', 'int') AS INT)
			,cast(@P_Xml.value('(/FileUploadLog/Log[sql:variable("@i")]/ProjectCode/text())[1]', 'VARCHAR(50)') AS VARCHAR(50))
			,cast(@P_Xml.value('(/FileUploadLog/Log[sql:variable("@i")]/UploadSessionId/text())[1]', 'uniqueidentifier') AS UNIQUEIDENTIFIER)
			,cast(@P_Xml.value('(/FileUploadLog/Log[sql:variable("@i")]/UploadDescription/text())[1]', 'VARCHAR(250)') AS VARCHAR(250))
			,cast(@P_Xml.value('(/FileUploadLog/Log[sql:variable("@i")]/RowNumber/text())[1]', 'INT') AS INT)
			,cast(@P_Xml.value('(/FileUploadLog/Log[sql:variable("@i")]/CreatedBy/text())[1]', 'VARCHAR(50)') AS VARCHAR(50))
			,GETDATE()
			,0
			,cast(@P_Xml.value('(/FileUploadLog/Log[sql:variable("@i")]/ColumnNumber/text())[1]', 'int') AS int));

		SET @i = @i + 1;
	END;
END;