
INSERT INTO [dbo].[Messages]
           ([MessageCode]
           ,[Message]
           ,[PageName]
           ,[Remarks])
     VALUES
           ('TYQNL'
           ,'This year quarters not locked'
           ,'Save Lock Year Procedure'
           ,'Save Error');

INSERT INTO [dbo].[Messages]
           ([MessageCode]
           ,[Message]
           ,[PageName]
           ,[Remarks])
     VALUES
           ('CPCCNA'
           ,'ClubbingParameterCode not active.'
           ,'Project'
           ,'Save Error') ;

UPDATE [dbo].[Messages]
   SET [Message] = 'Contract Type should be same as the one used in Clubbing Parameter'
      ,[PageName] = 'Project'
      ,[Remarks] = 'Save Error'
 WHERE [MessageCode] = 'CTNSCP';









