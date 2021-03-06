

ALTER PROCEDURE [dbo].[RemoveScenarioProjects] @P_ScenarioId int,@XMLData xml,@P_CreatedBy varchar(50)
AS
BEGIN
DECLARE @V_Id            INT;
DECLARE @i               INT = 1;
DECLARE @Count           INT = @XMLData.value('count(/TDS/TD)', 'int');
DECLARE @ProjectId       INT;
DECLARE @isSuccess       INT = 1;
DECLARE @ProjectMapCount INT;
DECLARE @V_Message       VARCHAR(200)='Success';
Declare @V_LogDescription varchar(4000) ;
DECLARE @V_Lock       bit;

 Select @V_Lock = ScenarioLock from Scenario where ScenarioID= @P_ScenarioId;

  If (@V_Lock =0)
  Begin

  WHILE @i <= @Count
  BEGIN 

 
    SET @ProjectId = Cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ProjectId/text())[1]', 'int') AS INT); 

	UPDATE [dbo].[ScenarioData]
   SET
      [Q1New] = 0
      ,[Q1Variant] = 0
      ,[Q2New] = 0
      ,[Q2Variant] = 0
      ,[Q3New] = 0
      ,[Q3Variant] = 0
      ,[Q4New] = 0
      ,[Q4Variant] = 0     
     ,UpdatedBy = @P_CreatedBy
	 ,UpdatedAt = getdate()
 WHERE scenarioid=@P_ScenarioId AND projectid=@ProjectId; 


    --SELECT @ProjectMapCount = Count(1) 
    --FROM   scenariodata 
    --WHERE  scenarioid=@P_ScenarioId 
    --AND    projectid=@ProjectId; 
     
    --IF(@ProjectMapCount>0) 
    --BEGIN 
    --  SET @isSuccess=0; 
    --  SET @V_Message ='Mapping Exist. So not allowed to remove.' 
    --END; 
    SET @i = @i + 1; 
  END;
  
  IF(@isSuccess=1) 
  BEGIN 
    SET @i =0; 
    WHILE @i <= @Count 
    BEGIN 
      SET @ProjectId = Cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ProjectId/text())[1]', 'int') AS INT); 
      DELETE 
      FROM   scenarioprojectmapper 
      WHERE  scenarioid=@P_ScenarioId 
      AND    projectid=@ProjectId; 
       
      SET @i = @i + 1; 
    END; 
  END;

   SET @V_LogDescription=cast(@XMLData as varchar(4000));
  Exec LogActivity 'RemoveScenarioProjects','Remove',@P_ScenarioId,@V_LogDescription,@P_CreatedBy ;

  End;
  Else
  Begin
  SET @V_Message ='Scenario Locked' 
  End;
  SELECT @V_Message;
  END

