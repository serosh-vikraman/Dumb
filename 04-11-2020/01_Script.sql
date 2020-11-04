


INSERT INTO [dbo].[Messages] ([MessageCode],[Message])  VALUES  ('DFCY','Only Forecast can be duplicated to next year.');
INSERT INTO [dbo].[Messages] ([MessageCode],[Message])  VALUES  ('DFCNY','Forecast can only be duplicated to same year or next year');
INSERT INTO [dbo].[Messages] ([MessageCode],[Message])  VALUES  ('DBOY','Only one Budget allowed in Year.');
INSERT INTO [dbo].[Messages] ([MessageCode],[Message])  VALUES  ('DSS','Success');
INSERT INTO [dbo].[Messages] ([MessageCode],[Message])  VALUES  ('OLSU','Only latest scenario can be unlocked.');


ALTER TABLE [Messages]
ADD PageName varchar(50),Remarks varchar(100);

