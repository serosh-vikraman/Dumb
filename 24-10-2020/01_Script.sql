

ALTER TABLE CurrencyExchange ADD CONSTRAINT UK_CurrencyExchange_Year_Quarter_Target Unique([Year],[Quarter],TargetCurrencyCode);



ALTER TABLE [dbo].[TemplateConfiguration] DROP CONSTRAINT [FK_TemplateConfiguration_ScenarioDataTypeId];

update [TemplateConfiguration] set ScenarioDataTypeId=20 where ScenarioDataTypeId=1 and TypeId =1;
update [TemplateConfiguration] set ScenarioDataTypeId=21 where ScenarioDataTypeId=2 and TypeId =1;
update [TemplateConfiguration] set ScenarioDataTypeId=23 where ScenarioDataTypeId=1 and TypeId =2;
update [TemplateConfiguration] set ScenarioDataTypeId=24 where ScenarioDataTypeId=2 and TypeId =2;
update [TemplateConfiguration] set ScenarioDataTypeId=25 where ScenarioDataTypeId=3 and TypeId =2;
update [TemplateConfiguration] set ScenarioDataTypeId=26 where ScenarioDataTypeId=4 and TypeId =2;




ALTER TABLE [dbo].[TemplateConfiguration]   ADD  CONSTRAINT [FK_TemplateConfiguration_ScenarioDataTypeId] FOREIGN KEY([ScenarioDataTypeId])
REFERENCES [dbo].[FinancialDataTypesScenario] ([ScenarioDataTypeID]);


ALTER TABLE CurrencyExchange ADD CONSTRAINT UK_CurrencyExchange_Year_Quarter_Target Unique([Year],[Quarter],TargetCurrencyCode);


ALTER TABLE LockQuarter
DROP CONSTRAINT FK_LockQuarter_Year;

ALTER TABLE Scenario
DROP CONSTRAINT FK_Scenario_FinancialYear;


