
ALTER PROCEDURE [dbo].[DeleteScenario] @P_Id int, @P_User varchar(100)
	
AS
BEGIN

declare @V_ProjectCount int=0;
declare @V_DataCount int=0;
declare @V_Message varchar(250);
DECLARE @V_MessageCode      VARCHAR(20)='DS';
declare @V_Lock bit;
declare @V_ScenarioName varchar(20);
declare @V_Description varchar(2000);

select @V_DataCount=count(1) from ScenarioData where (ScenarioId = @P_Id);
If (@V_DataCount>0)
Begin
Set @V_MessageCode = 'SDEPS';
end;

If (@V_DataCount=0)
Begin

Select @V_Lock = ScenarioLock, @V_ScenarioName = ScenarioName from Scenario where ScenarioID = @P_Id;

If (@V_Lock = 0)

Begin
Select @V_Description =  STRING_AGG(CASE isnull(p.IFSProjectCode, '')
		WHEN ''
			THEN p.[ManualProjectCode]
		ELSE p.IFSProjectCode
		END , ',') from ScenarioProjectMapper spm
left join Project p on spm.ProjectID = p.ProjectID
where (ScenarioId = @P_Id);

DELETE FROM [dbo].[ScenarioProjectMapper]
      WHERE ScenarioId= @P_Id;
DELETE FROM [dbo].[ScenarioFiles]
      WHERE ScenarioId= @P_Id;
DELETE FROM [dbo].[ScenarioUploadLog]
      WHERE ScenarioId= @P_Id;
DELETE FROM [dbo].[ScenarioApplicableYears]
      WHERE ScenarioId= @P_Id;

DELETE FROM [dbo].Scenario
      WHERE ScenarioID = @P_Id;

Exec LogActivity 'Scenario','DELETE',@P_Id,@V_ScenarioName,@P_User;
Exec LogActivity 'ScenarioApplicableYears','DELETE',@P_Id,@V_ScenarioName,@P_User;
Exec LogActivity 'ScenarioProjectMapper','DELETE',@P_Id,@V_Description,@P_User;
End;

Else

begin
Set @V_MessageCode = 'SL';
end;
end 
SET @V_Message = (SELECT [Message] FROM [Messages] WHERE MessageCode = @V_MessageCode);
 Select @V_Message;
END

