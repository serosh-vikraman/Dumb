 

ALTER PROCEDURE [dbo].[SaveScenarioProjectLog] @P_ScenarioId int,@P_ProjectId int,@P_Status bit,
@P_CreatedBy varchar(50) 
	
AS
BEGIN
Declare @V_Id int;
Declare @V_SubAction varchar(100);
Declare @V_Name varchar(50);
Declare @V_Code varchar(5);
Declare @V_Active bit;
Declare @V_LogDescription varchar(500) ;

IF @P_Status=1
BEGIN
INSERT INTO ScenarioProjectLog
           (ScenarioId
           ,ProjectId
		   ,[Status]
           ,CreatedBy
           ,CreatedAt)
          
     VALUES
           (@P_ScenarioId
           ,@P_ProjectId
		   ,@P_Status
           ,@P_CreatedBy
		   ,GetDate()
           );

	Select @V_Id = @@IDENTITY;
	SET @V_SubAction='SAVE';

  Exec LogActivity 'ScenarioProjectLog',@V_SubAction,@V_Id,'',@P_CreatedBy;
 Select @V_Id, @P_Status as [Status];
 END;
 ELSE
 BEGIN
 UPDATE ScenarioProjectLog SET [Status]=@P_Status where ScenarioId = @P_ScenarioId AND ProjectId=@P_ProjectId;
  Select TOP 1 ScenarioProjectLogID, [Status] from ScenarioProjectLog where ScenarioId = @P_ScenarioId AND ProjectId=@P_ProjectId
  ORDER BY 1 DESC;
  END;

 
END
