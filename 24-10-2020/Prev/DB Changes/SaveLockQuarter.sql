
 
ALTER PROCEDURE [dbo].[SaveLockQuarter] @P_Id int,@P_Year int,@P_Quarter varchar(50),@P_Lock bit,@P_CreatedBy varchar(50)
	
AS
Declare @V_Id int = 0;
Declare @V_SubAction varchar(100);
Declare @V_Year int;
Declare @V_Quarter varchar(50);
Declare @V_Lock bit;
Declare @V_YearLock bit;
Declare @isSuccess int = 1;
Declare @V_Message varchar(50)='Success';

Declare @V_LogDescription varchar(500) ;
BEGIN
If (@P_Id = 0)
Begin

INSERT INTO [dbo].[LockQuarter]
           ([Year]
           ,[Quarter]
           ,[CreatedBy]
           ,[CreatedAt]
           )
     VALUES
           (@P_Year
           ,@P_Quarter
           ,@P_CreatedBy
           ,getdate()
           );

		   Select @V_Id = @@IDENTITY;
		   SET @V_SubAction='SAVE';
 End
Else
begin

SELECT @V_Year= [Year], @V_Quarter =[Quarter],@V_Lock= [Lock] from 
[dbo].[LockQuarter] WHERE Id = @P_Id;

If (@P_Lock = 0)
Begin
SELECT @V_YearLock = [Lock] from LockYear WHERE [Year] = @V_Year;
If (@V_YearLock = 1) SET @isSuccess = 0; SET @V_Message = 'Year Locked';
End

if (@isSuccess = 1)
Begin
UPDATE [dbo].[LockQuarter]
   SET [Year] = @P_Year
      ,[Quarter] = @P_Quarter
      ,[Lock] = @P_Lock
      ,[UpdatedBy] = @P_CreatedBy
      ,[UpdatedAt] = getdate()
 WHERE Id = @P_Id;
 SET @V_SubAction='UPDATE';
 Select @V_Id = @P_Id;
 IF @V_Year!=@P_Year
		SET @V_LogDescription =@V_LogDescription + ', [Year]= '+CAST( @V_Year as varchar(10)) +' -> '+CAST( @P_Year as varchar(10));
IF @V_Quarter!=@P_Quarter
		SET @V_LogDescription =@V_LogDescription + ', [Quarter]= '+ @V_Quarter  +' -> '+ @P_Quarter;
IF @V_Lock!=@P_Lock
		SET @V_LogDescription =@V_LogDescription + ', [Lock]= '+CAST( @V_Lock as varchar(10)) +' -> '+CAST( @P_Lock as varchar(10));
 end
 End
 Exec LogActivity 'LockQuarter',@V_SubAction,@V_Id,@V_LogDescription,@P_CreatedBy;
 Select @V_Id, @V_Message;
END
