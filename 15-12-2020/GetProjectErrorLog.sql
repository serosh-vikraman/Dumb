
 ALTER PROCEDURE [dbo].[GetProjectErrorLog] @P_SessionId varchar(50) 
AS
BEGIN

Select [SessionID]
								,[RowNumber]
								,[ColumnNumber]
								,[Status]
								,[Message]
								,[CreatedBy]
								 
								,[ErrorCode] from [ProjectUploadLog] where SessionId=@P_SessionId
								ORDER BY [RowNumber]
								,[ColumnNumber]
 
END;
