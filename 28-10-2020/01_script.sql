DELETE FROM ScenarioData WHERE ScenarioID = 150

DELETE FROM [dbo].[ScenarioProjectMapper]
      WHERE ScenarioId= 150
  DELETE FROM [dbo].[ScenarioUploadLog]
      WHERE ScenarioId= 150;
  DELETE FROM [dbo].[ScenarioFiles]
      WHERE ScenarioId= 150;
DELETE FROM [dbo].[ScenarioApplicableYears]
      WHERE ScenarioId= 150;
DELETE FROM [dbo].Scenario
      WHERE ScenarioId = 150;