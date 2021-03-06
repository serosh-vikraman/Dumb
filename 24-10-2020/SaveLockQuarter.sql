 
 
ALTER PROCEDURE [dbo].[SaveLockQuarter] @P_Id int,@P_Year int,@P_Quarter varchar(50),@P_Lock bit,@P_CreatedBy varchar(50)
	
AS
Declare @V_Id int = 0;
Declare @V_SubAction varchar(100);
Declare @V_Year int;
Declare @V_Quarter varchar(50);
Declare @V_Lock bit;
Declare @Lock bit;
Declare @V_YearLock bit;
Declare @isSuccess int = 1;
Declare @V_Message varchar(50)='Success';

Declare @V_LogDescription varchar(500) ;
BEGIN
If (@P_Id = 0)
Begin
If (@P_Quarter = 'Q1')
BEGIN
Select @Lock = Lock from LockQuarter where [Quarter]  = 'Q4' and [Year] = @P_Year-1
If @Lock = 0 SET @isSuccess = 0; SET @V_Message = 'Previous quarter not locked'
END;
If (@P_Quarter = 'Q2')
BEGIN
Select @Lock = Lock from LockQuarter where [Quarter]  = 'Q1' and [Year] = @P_Year
If @Lock = 0 SET @isSuccess = 0; SET @V_Message = 'Previous quarter not locked'
END;
If (@P_Quarter = 'Q3')
BEGIN
Select @Lock = Lock from LockQuarter where [Quarter]  = 'Q2' and [Year] = @P_Year
If @Lock = 0 SET @isSuccess = 0; SET @V_Message = 'Previous quarter not locked'
END;
If (@P_Quarter = 'Q4')
BEGIN
Select @Lock = Lock from LockQuarter where [Quarter]  = 'Q3' and [Year] = @P_Year
If @Lock = 0 SET @isSuccess = 0; SET @V_Message = 'Previous quarter not locked'
END;

IF (@isSuccess = 1)
BEGIN 
INSERT INTO [dbo].[LockQuarter]
           ([Year]
           ,[Quarter]
		   ,Lock
           ,[CreatedBy]
           ,[CreatedAt]
           )
     VALUES
           (@P_Year
           ,@P_Quarter
		   ,@P_Lock
           ,@P_CreatedBy
           ,getdate()
           );

		   Select @V_Id = @@IDENTITY;
		   SET @V_SubAction='SAVE';
END

END

Else

BEGIN

SELECT @V_Year= [Year], @V_Quarter =[Quarter],@V_Lock= [Lock] from 
[dbo].[LockQuarter] WHERE Id = @P_Id;

If (@P_Lock = 0)
BEGIN
SELECT @V_YearLock = [Lock] FROM LockYear WHERE [Year] = @V_Year;
If (@V_YearLock = 1)
BEGIN SET @isSuccess = 0; SET @V_Message = 'Year Locked' END;
ELSE 
BEGIN
If (@P_Quarter = 'Q1')
BEGIN
Select @Lock = Lock from LockQuarter where [Quarter]  = 'Q2' and [Year] = @P_Year
If @Lock = 1 SET @isSuccess = 0; SET @V_Message = 'Quarter 2 of this Year locked'
END;
If (@P_Quarter = 'Q2')
BEGIN
Select @Lock = Lock from LockQuarter where [Quarter]  = 'Q3' and [Year] = @P_Year
If @Lock = 1 SET @isSuccess = 0; SET @V_Message = 'Quarter 3 of this Year locked'
END;
If (@P_Quarter = 'Q3')
BEGIN
Select @Lock = Lock from LockQuarter where [Quarter]  = 'Q4' and [Year] = @P_Year
If @Lock = 1 SET @isSuccess = 0; SET @V_Message = 'Quarter 4 of this Year locked'
END;
If (@P_Quarter = 'Q4')
BEGIN
Select @Lock = Lock from LockQuarter where [Quarter]  = 'Q1' and [Year] = @P_Year +1
If @Lock = 1 SET @isSuccess = 0; SET @V_Message = 'Quarter 1 of next year is locked'
END;
END;
END

if (@isSuccess = 1)
BEGIN
UPDATE [dbo].[LockQuarter]
   SET [Year] = @P_Year
      ,[Quarter] = @P_Quarter
      ,[Lock] = @P_Lock
      ,[UpdatedBy] = @P_CreatedBy
      ,[UpdatedAt] = getdate()
 WHERE Id = @P_Id;
 SET @V_SubAction='UPDATE';
 SELECT @V_Id = @P_Id;
 IF @V_Year!=@P_Year
		SET @V_LogDescription =@V_LogDescription + ', [Year]= '+CAST( @V_Year as varchar(10)) +' -> '+CAST( @P_Year as varchar(10));
IF @V_Quarter!=@P_Quarter
		SET @V_LogDescription =@V_LogDescription + ', [Quarter]= '+ @V_Quarter  +' -> '+ @P_Quarter;
IF @V_Lock!=@P_Lock
		SET @V_LogDescription =@V_LogDescription + ', [Lock]= '+CAST( @V_Lock as varchar(10)) +' -> '+CAST( @P_Lock as varchar(10));
 END
 END
 EXEC LogActivity 'LockQuarter',@V_SubAction,@V_Id,@V_LogDescription,@P_CreatedBy;
 SELECT @V_Id, @V_Message;
END
