
ALTER procedure [dbo].[GetScenarioFileUploadLogs]
as
begin


select A.UploadSessionId,
RIGHT(A.ScenarioFileName , LEN(A.ScenarioFileName) - CHARINDEX('_', A.ScenarioFileName) )  ScenarioFileName,
A.CreatedAt,
A.CreatedBy,
A.ScenarioId,
A.TypeId,B.ScenarioName from
[dbo].[ScenarioFiles] A 
inner join [Scenario] B 
on A.[ScenarioID]=B.ScenarioID order by A.CreatedAt desc ;
end
