
INSERT INTO [dbo].[Messages]
           ([MessageCode]
           ,[Message]
           ,[PageName]
           ,[Remarks])
     VALUES
           ('YNDQEP'
           ,'Year cannot be deleted as Quarter entries are present.'
           ,'LockYear'
           ,'Deletion Error');

INSERT INTO [dbo].[Messages]
           ([MessageCode]
           ,[Message]
           ,[PageName]
           ,[Remarks])
     VALUES
           ('YND'
           ,'Year could not be deleted.'
           ,'LockYear'
           ,'Deletion Error');

INSERT INTO [dbo].[Messages]
           ([MessageCode]
           ,[Message]
           ,[PageName]
           ,[Remarks])
     VALUES
           ('YDS'
           ,'Year deleted successfully.'
           ,'LockYear'
           ,'Deletion Success');

INSERT INTO [dbo].[Messages]
           ([MessageCode]
           ,[Message]
           ,[PageName]
           ,[Remarks])
     VALUES
           ('YNUAUS'
           ,'Year cannot be updated as it is used in Scenario.'
           ,'LockYear'
           ,'Updation Error');

INSERT INTO [dbo].[Messages]
           ([MessageCode]
           ,[Message]
           ,[PageName]
           ,[Remarks])
     VALUES
           ('YAU'
           ,'Year already used.'
           ,'LockYear'
           ,'Updation Error');

INSERT INTO [dbo].[Messages]
           ([MessageCode]
           ,[Message]
           ,[PageName]
           ,[Remarks])
     VALUES
           ('YSS'
           ,'Year saved successfully.'
           ,'LockYear'
           ,'Save Success');


