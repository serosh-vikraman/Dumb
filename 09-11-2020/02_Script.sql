
 

TRUNCATE TABLE [dbo].[Messages];
 
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SVCDNS', N'SmartViewCode cannot be deleted as it is used in a Project.', N'ProjectAttribute-SmartViewCode', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SVCDS', N'SmartViewCode deleted Successfully.', N'ProjectAttribute-SmartViewCode', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SVCNUAUP', N'SmartViewCode cannot be updated as it is used in a Project.', N'ProjectAttribute-SmartViewCode', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SVCNAU', N'SmartViewCode or Name already used.', N'ProjectAttribute-SmartViewCode', N'Duplicate Entry Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'GPNS', N'GroupingParameters could not be saved.', N'ProjectAttribute-GroupingParameters', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'GPSS', N'GroupingParameters saved successfully.', N'ProjectAttribute-GroupingParameters', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CEND', N'CurrencyExchange could not be deleted.', N'CurrencyExchange', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BUCSS', N'BUCategory saved successfully.', N'ProjectAttribute-BUCategory', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BTDNS', N'BillingType cannot be deleted as it is used in Project.', N'ProjectAttribute-BillingType', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BTDS', N'BillingType deleted successfully.', N'ProjectAttribute-BillingType', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'DUMPC', N'Duplicate Manual Project Code', N'Project', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MCCNA', N'ManagementCategoryCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'GPCNA', N'GroupingParametersCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SVCNA', N'SmartViewCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CSCNA', N'ContractStatusCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CTCNA', N'ContractTypeCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PDS', N'Project deleted successfully.', N'Project', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BTCNA', N'BillingTypeCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CCNA', N'CountryCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SCCNA', N'StatutoryCategoryCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BUCCNA', N'BUCategoryCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PECNA', N'ProjectEntityCode is not Active', N'Project', N'Inactive Attribute Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MCDS', N'Management category deleted Successfully.', N'ProjectAttribute-Management Category', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MCNUUP', N'Management category cannot be updated as it is used in a Project.', N'ProjectAttribute-Management Category', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MCCNAU', N'Management category Code or Name already used.', N'ProjectAttribute-Management Category', N'Duplicate Entry Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MCNS', N'Management Category could not be saved.', N'ProjectAttribute-Management Category', N'Insertion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MCSS', N'Management category saved successfully.', N'ProjectAttribute-Management Category', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'YNDQEP', N'Year cannot be deleted as Quarter entries are present.', N'LockYear', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'YND', N'Year could not be deleted.', N'LockYear', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'YDS', N'Year deleted successfully.', N'LockYear', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'YNUAUS', N'Year cannot be updated as it is used in Scenario.', N'LockYear', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'YAU', N'Year already used.', N'LockYear', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'YSS', N'Year saved successfully.', N'LockYear', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'QDNS', N'Quarter could not be deleted.', N'LockQuarter', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'QDS', N'Quarter deleted Successfully.', N'LockQuarter', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'QNUAUS', N'Quarter cannot be updated as it is used in Scenario.', N'LockQuarter', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'QAU', N'Quarter already entered.', N'LockQuarter', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'QSS', N'Quarter saved successfully.', N'LockQuarter', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'GPNDAUP', N'Grouping Parameter cannot be deleted as it is used in a Project.', N'ProjectAttribute-Grouping Parameters', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'GPDS', N'GroupingParameters deleted Successfully', N'ProjectAttribute-Grouping Parameters', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'GPNUAUP', N'Grouping Parameter cannot be updated as it is used in a Project.', N'ProjectAttribute-Grouping Parameters', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'GPCNAU', N'Grouping Parameter Code or Name already used.', N'ProjectAttribute-Grouping Parameters', N'Duplicate Entry Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CEDS', N'CurrencyExchange deleted Successfully.', N'Currency Exchange', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CEAE', N'Exchange rate for this Quarter and Year already entered for this Currency.', N'Currency Exchange', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CENS', N'Could not save Currency Exchange.', N'Currency Exchange', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CESS', N'Currency Exchange saved successfully.', N'Currency Exchange', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CUDNSUP', N'Currency cannot be deleted as it is used in CurrencyExchange.', N'Currency ', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CUDNS', N'Currency could not be deleted.', N'Currency ', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CUDS', N'Currency deleted Successfully.', N'Currency ', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CUCAUP', N'Currency Code cannot be edited as used in CurrencyExchange.', N'Currency ', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CUCNAU', N'Currency Code or Name already used.', N'Currency ', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CUSNS', N'Could not save Currencey', N'Currency ', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CUSSS', N'Currency saved successfully.', N'Currency ', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CDNS', N'Country cannot be deleted as it is used in Project.', N'Country', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CDS', N'Country deleted Successfully.', N'Country', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CCNUP', N'Country cannot be updated as it is used in Project.', N'Country', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CCNAU', N'Country Code or Name already used.', N'Country', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CNS', N'Country could not be saved.', N'Country', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CSS', N'Country saved successfully.', N'Country', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CTDNSUP', N'Contract Type cannot be deleted as it is used in a Project.', N'Contract Type', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CTDS', N'ContractType deleted Successfully.', N'Contract Type', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CTNUAUP', N'Contract Type cannot be updated as it is used in a Project.', N'Contract Type', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CTCNAU', N'Contract Type Code or Name already used.', N'Contract Type', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CTNS', N'Could not save ContractType.', N'Contract Type', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CTSS', N'ContractType saved successfully.', N'Contract Type', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CSDNS', N'ContractStatus cannot be deleted as it is used in a Project.', N'Contract Status', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CSDS', N'ContractStatus deleted successfully', N'Contract Status', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CSCAUP', N'ContractStatus cannot be updated as it is used in a Project.', N'Contract Status', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CSCNAU', N'ContractStatus Code or Name already used.', N'Contract Status', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CSNS', N'ContractStatus could not be saved.', N'Contract Status', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'CSSS', N'ContractStatus saved successfully.', N'Contract Status', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BUCND', N'BUCategory cannot be deleted as it is used in a Project.', N'BUCategory', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BUCDS', N'BUCategory deleted successfully.', N'BUCategory', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BUCNU', N'BUCategory cannot be updated as it is used in a Project.', N'BUCategory', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BUCCNAU', N'BUCategory Code or Name already used.', N'BUCategory', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BUCNS', N'BUCategory could not be saved.', N'BUCategory', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BTUP', N'Billing Type cannot be updated as it is used in Project.', N'Billing Type', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BTCNAU', N'Billing Type Code or Name already used.', N'Billing Type', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BTNS', N'BillingType could not be saved.', N'Billing Type', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BTSS', N'BillingType saved successfully.', N'Billing Type', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'Q1NYL', N'Quarter 1 of next year is locked', N'LockQuarter', N'Quarter4 cannot be unlocked as Quarter 1 of next year is already locked')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'Q4YL', N'Quarter 4 of this Year locked', N'LockQuarter', N'Quarter3 cannot be unlocked as Quarter 4 of this year is already locked')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'Q3YL', N'Quarter 3 of this Year locked', N'LockQuarter', N'Quarter2 cannot be unlocked as Quarter 3 of this year is already locked')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'Q2YL', N'Quarter 2 of this Year locked', N'LockQuarter', N'Quarter1 cannot be unlocked as Quarter 2 of thisyear is already locked')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PQNL', N'Previous quarter not locked', N'LockQuarter', N'Quarter cannot be locked as Previous Quarter is not Locked')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'LQSS', N'Success', N'Quarter Save Procedure', N'Procedure')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PSCNA', N'ProjectSegmentCode is not Active', N'Project', N'Project Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PSS', N'Success', N'Procedure', NULL)
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SL', N'Scenario is Locked', N'Scenario', N'generic')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SDEPS', N'Scenario Data Entry present for Scenario', N'Scenario', NULL)
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'DS', N'IsSuccess', N'Duplicate Scenario Procedure', NULL)
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'FAAE', N'Forecast/Actuals already entered for this ScenarioScope for this Year.', N'Scenario', N'Budget cannot be unlocked if Forecast or Actuals are already entered for this Scenario Scope.')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'OLSU', N'Only latest scenario can be unlocked.', N'Scenario', N'')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'YL', N'Year locked.', N'', N'generic-used in quarter and sccenario')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PYNL', N'Previous Year not locked.', N'Scenario', N'Budget cannot be locked if Previous Year not locked')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MFAAE', N'Maximum of four Actuals already entered.', N'Scenario ', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BDYSAE', N'Budget for this year and scope already entered', N'Scenario', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BDYSNC', N'Budget for this year and scope not created', N'Scenario', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'BDYNL', N'Budget for this year not locked', N'Scenario', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SSS', N'Success', N'Procedure', NULL)
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SVCNS', N'SmartViewCode could not be saved.', N'Project Attribute-SmartViewCode', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SVCSS', N'SmartViewCode saved successfully.', N'Project Attribute-SmartViewCode', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SSCNAU', N'ScenarioScope Code or Name already used.', N'ScenarioScope ', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SSNS', N'Scenarioscope could not be saved.', N'Scenario Scope', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SSSS', N'ScenarioScope saved successfully.', N'Scenario Scope ', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PDCNS', N'Project data could not be cleared.', N'Quarterly data Entry', N'Clear Project Data Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PDCS', N'Project data cleared successfully.', N'Quarterly data Entry', N'Clear Project Data Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SDCNS', N'Another user working in this Scenario.', N'Quarterly data Entry', N'Clear Scenario Data')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SDCS', N'Scenario data cleared successfully.', N'Quarterly data Entry', N'Clear Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SDDNS', N'Scenario data could not be deleted.', N'Quarterly data Entry', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SDDS', N'Scenario data deleted successfully.', N'Quarterly data Entry', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SDNS', N'Scenario data could not be saved.', N'Quarterly data Entry', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SDSS', N'Scenario data saved successfully.', N'Quarterly data Entry', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PRS', N'Project removed successfully.', N'Scenario ', N'Removal of Associated Project Successfull')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SDS', N'Scenario duplicated successfully.', N'Duplicate Scenario', N'Duplication Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SMPNS', N'Scenario could not be mapped to Project', N'Associate Project', N'Association Failure')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SMPS', N'Scenario mapped to Project successfully.', N'AssociateProject', N'Succesfull')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MSDS', N'Scenarios deleted successfully.', N'Scenario', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PASC', N'Projects are associated with Scenario.', N'Scenario', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SCDS', N'Scenario deleted successfully.', N'Scenario', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'SCSS', N'Scenario saved successfully', N'Scenario', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'RPDNS', N'Role Permission could not be deleted.', N'RolePermission', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'RPDS', N'Role Permission deleted successfully.', N'RolePermission', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'RPNS', N'RolePermission could not be saved.', N'RolePermission', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'RPSS', N'RolePermission saved successfully.', N'RolePermission', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PSDNS', N'Project Segment cannot be deleted as it is used in a Project.', N'Project Segment', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PSDS', N'ProjectSegment deleted successfully.', N'Project Segment', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PSNUUP', N'Project Segment cannot be updated as it is used in a Project.', N'Project Segment', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PSCNAU', N'Project Segment Code or Name already used.', N'Project Segment', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PSNS', N'ProjectSegment could not be saved.', N'Project Segment', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PSSS', N'ProjectSegment saved successfully.', N'Project Segment', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PEDNS', N'Project Entity cannot be deleted as it is used in Project.', N'Project Entity', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PEDS', N'ProjectEntity deleted successfully.', N'Project Entity', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PENUAUP', N'Project Entity cannot be updated as it is used in Project.', N'Project Entity', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PECNAU', N'Project Entity Code or Name already used.', N'Project Entity', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PENS', N'ProjectEntity could not be saved.', N'Project Entity', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PESS', N'ProjectEntity saved successfully.', N'Project Entity', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PDLNS', N'Project could not be delinked.', N'Project', N'Delink Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PDLS', N'Project delinked successfully', N'Project', N'Delink Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PLNS', N'Project could not be linked.', N'Project', N'Link Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PLS', N'Project linked successfully.', N'Project', N'Link Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PAS', N'Project associated with Scenario.', N'Project', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PNAU', N'Project Name already used.', N'Project', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MPCAU', N'Manual Project Code already used.', N'Project ', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'PRSS', N'Project saved successfully.', N'Project', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'MCNDUP', N'Management category cannot be deleted as it is used in a Project.', N'Management Category', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'STCSS', N'Statutory Category saved successfully.', N'Statutory Category', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'STCNS', N'Statutory Category could not be saved.', N'Statutory Category', N'SaveError')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'STCNAU', N'Statutory Category Code or Name already used.', N'Statutory Category', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'STCNUAUP', N'Statutory Category cannot be updated as it is used in a Project.', N'Statutory Category', N'Updation Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'STCDS', N'StatutoryCategory deleted successfully.', N'Statutory Category', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'STCDNS', N'Statutory Category cannot be deleted as it is used in a Project.', N'Statutory Category', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'UPSS', N'UserPermission saved successfully.', N'UserPermission', N'Save Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'UPNS', N'UserPermission could not be saved.', N'UserPermission', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'UPDS', N'UserPermission deleted successfully.', N'UserPermission', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'UPDNS', N'UserPermission could not be deleted.', N'UserPermission', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'URSS', N'UserRole saved successfully.', N'UserRole', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'URNS', N'UserRole could not be saved.', N'UserRole', N'Save Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'URCNAU', N'UserRole Code or Name already used.', N'UserRole', N'Duplicate Entry')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'URDS', N'UserRole deleted successfully.', N'UserRole', N'Deletion Success')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'URDNS', N'UserRole could not be deleted.', N'UserRole', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'URDNURP', N'User Role cannot be deleted as it is used in RolePermissions.', N'UserRole', N'Deletion Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'DFCY', N'Only Forecast can be duplicated to next year', N'Scenario Duplication', N'Duplication to next year Error')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'DFCNY', N'Forecast can only be duplicated to same year or next year', N'Scenario Duplication', NULL)
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'DBOY', N'Only one Budget allowed in Year.', N'Scenario', N'')
GO
INSERT [dbo].[Messages] ([MessageCode], [Message], [PageName], [Remarks]) VALUES (N'DSS', N'Success', N'Procedure', NULL)
GO
 