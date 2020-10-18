

Alter table Project Add Constraint UK_Project_ProjectName Unique(ProjectName); 

ALTER TABLE Project 
ALTER COLUMN ProjectName varchar(250);

ALTER TABLE Project 
ALTER COLUMN Notes varchar(3000);

ALTER TABLE Scenario 
ALTER COLUMN [Description] varchar(3000);

ALTER TABLE CurrencyExchange 
DROP COLUMN CancelStatus;

UPDATE FinancialDataTypesScenario SET ScenarioTypeID=3, ScenarioTypeCode='AC' 
WHERE ScenarioTypeCode='FC' and ScenarioScopeCode = 'BL';