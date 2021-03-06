USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[DeleteScenario]    Script Date: 17-10-2020 08:11:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[DeleteMultipleScenario]  @P_User varchar(100),@XMLData xml 
	
AS
BEGIN
DECLARE @i               INT = 1;
DECLARE @Count           INT = @XMLData.value('count(/TDS/TD)', 'int');
DECLARE @V_ProjectCount int=0;
DECLARE @V_DataCount int=0;
DECLARE @V_Message varchar(200) = 'IsSuccess';
DECLARE @V_Lock bit;
DECLARE @V_Description varchar(2000);
DECLARE @V_ScenarioId      INT = 1;
DECLARE @V_ScenarioName varchar(100);


 WHILE @i <= @Count
  BEGIN 


    SET @V_ScenarioId = Cast(@XMLData.value('(/TDS/TD[sql:variable("@i")]/ScenarioId/text())[1]', 'int') AS INT); 

	SELECT @V_ScenarioName = ScenarioName from Scenario where ScenarioId = @V_ScenarioId;
	select @V_DataCount=count(1) from ScenarioData where ScenarioId = @V_ScenarioId;

If (@V_DataCount>0)
Begin
Set @V_Message = 'Scenario Data Entry present for Scenario '+ CAST( @V_ScenarioName as varchar(100));
end;

If (@V_DataCount=0)
Begin

Select @V_Lock = ScenarioLock from Scenario where ScenarioID = @V_ScenarioId;

If (@V_Lock = 0)

Begin

Select @V_Description =  STRING_AGG(CASE isnull(p.IFSProjectCode, '')
		WHEN ''
			THEN p.[ManualProjectCode]
		ELSE p.IFSProjectCode
		END , ',') from ScenarioProjectMapper spm
left join Project p on spm.ProjectID = p.ProjectID
where (ScenarioId = @V_ScenarioId);

DELETE FROM [dbo].[ScenarioProjectMapper]
      WHERE ScenarioId= @V_ScenarioId;
DELETE FROM [dbo].[ScenarioApplicableYears]
      WHERE ScenarioId= @V_ScenarioId;
DELETE FROM [dbo].Scenario
      WHERE ScenarioId = @V_ScenarioId;

Exec LogActivity 'Scenario','DELETE',@V_ScenarioId,@V_ScenarioName,@P_User;
Exec LogActivity 'ScenarioApplicableYears','DELETE',@V_ScenarioId,@V_ScenarioName,@P_User;
Exec LogActivity 'ScenarioProjectMapper','DELETE',@V_ScenarioId,@V_Description,@P_User;
End;

Else

begin
Set @V_Message = 'Scenario' + CAST(@V_ScenarioName as varchar(100)) + 'is Locked';
end;
end 

    SET @i = @i + 1; 
  END;
  


 Select @V_Message;
END

