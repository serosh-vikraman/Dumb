
CREATE PROCEDURE [dbo].[GetLegacyInsertionStatus] 
AS
BEGIN 
SELECT TOP(1) LegacyInsertionFlag FROM LegacyInsertion;
END