
--exec SaveLockYear 0,2020,1,'1'
ALTER PROCEDURE [dbo].[SaveLockYear] @P_Id int,@P_Year int,@P_Lock bit,@P_CreatedBy varchar(50)
	
AS
Declare @V_Id int = 0;
Declare @V_SubAction varchar(100);
Declare @V_Year int;
Declare @V_Lock bit;
Declare @V_QuarterLock int;
Declare @V_PreviousYearLock bit;
Declare @V_LogDescription varchar(500) ;
Declare @V_LogDescription1 varchar(500) ;
Declare @isSuccess int = 1;
Declare @V_Message varchar(50)='Success';

BEGIN


If (@P_Id = 0)
BEGIN
SELECT @V_PreviousYearLock = Lock FROM LockYear WHERE [Year] = @P_Year - 1;
IF (@V_PreviousYearLock = 0)
BEGIN
 SET @isSuccess = 0; SET @V_Message = 'Previous year not locked'
END;
SET @V_QuarterLock = (SELECT Count(1) FROM LockQuarter WHERE [Quarter] IN ('Q1','Q2','Q3','Q4') and Lock = 1 and [Year] =@P_Year); 
IF (@V_QuarterLock <> 4)
BEGIN
 SET @isSuccess = 0; SET @V_Message = 'This year quarters not locked'
END;
IF (@isSuccess = 1)
BEGIN

INSERT INTO [dbo].[LockYear]
           ([Year]  
		   ,[Lock]
           ,[CreatedBy]
           ,[CreatedAt]
           )
     VALUES
           (@P_Year 
		   ,1
           ,@P_CreatedBy
           ,getdate()
           );
		   SET @V_SubAction='SAVE';
		   Select @V_Id = @@IDENTITY;

  UPDATE Scenario SET ScenarioLock = 1 WHERE FinancialYear = @P_Year;

END;

END;

ELSE

BEGIN

SELECT @V_Year= [Year], @V_Lock= [Lock] from 
[dbo].[LockYear] WHERE Id = @P_Id;

 If(@P_Lock = 1) 
 BEGIN
SELECT @V_PreviousYearLock = Lock FROM LockYear WHERE [Year] = @P_Year - 1;
IF (@V_PreviousYearLock = 0)
BEGIN
 SET @isSuccess = 0; SET @V_Message = 'Previous year not locked'
END;
SET @V_QuarterLock = (SELECT Count(1) FROM LockQuarter WHERE [Quarter] IN ('Q1','Q2','Q3','Q4') and Lock = 1 and [Year] =@P_Year); 
IF (@V_QuarterLock <> 4)
BEGIN
 SET @isSuccess = 0; SET @V_Message = 'This year quarters not locked'
END;
END;
ELSE
BEGIN
SELECT @V_PreviousYearLock = Lock FROM LockYear WHERE [Year] = @P_Year + 1;
IF (@V_PreviousYearLock = 1) BEGIN  SET @isSuccess = 0; SET @V_Message = 'New Year Created.';END;
 END;

 IF (@isSuccess = 1)
BEGIN
UPDATE [dbo].[LockYear]
   SET [Year] = @P_Year      
      ,[Lock] = @P_Lock
      ,[UpdatedBy] = @P_CreatedBy
      ,[UpdatedAt] = getdate()
 WHERE Id = @P_Id;
 If (@P_Lock = 1) and (@isSuccess = 1)
 Begin
 UPDATE Scenario SET ScenarioLock = 1 WHERE FinancialYear = @P_Year;
  Exec LogActivity 'Scenario','Lock',@V_Id, @V_LogDescription1,@P_CreatedBy;
  End


 Select @V_Id = @P_Id;
 SET @V_SubAction='UPDATE';
 Select @V_Id = @P_Id;
 IF @V_Year!=@P_Year
		SET @V_LogDescription =@V_LogDescription + ', [Year]= '+CAST( @V_Year as varchar(10)) +' -> '+CAST( @P_Year as varchar(10));
IF @V_Lock!=@P_Lock
		SET @V_LogDescription =@V_LogDescription + ', [Lock]= '+CAST( @V_Lock as varchar(10)) +' -> '+CAST( @P_Lock as varchar(10));
END;
END;
 Exec LogActivity 'LockYear',@V_SubAction,@V_Id,@V_LogDescription,@P_CreatedBy;
 Select @V_Id, @V_Message;

END
