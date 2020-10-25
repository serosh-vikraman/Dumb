

ALTER PROCEDURE [dbo].[GetAllWIPStatusTrueScenario] 
	
AS
BEGIN
 
  SELECT DISTINCT A.ScenarioId,A.CreatedBy,B.ScenarioName FROM ScenarioProjectLog A
  INNER JOIN Scenario B ON A.Scenarioid=B.ScenarioId
  WHERE [Status] = 1

END
