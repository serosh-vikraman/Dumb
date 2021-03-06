

CREATE PROCEDURE [dbo].[SaveClubbingParameter] @P_Id int,@P_ClubbingParameterName varchar(50),@P_ClubbingParameterCode varchar(5),
@P_CreatedBy varchar(50),@P_Active bit
	
AS
BEGIN
Declare @V_Id int;
Declare @V_SubAction varchar(100);
Declare @V_Name varchar(50);
Declare @V_Code varchar(5);
Declare @V_Active bit;
Declare @V_LogDescription varchar(500) ;

If (@P_Id = 0)
begin
INSERT INTO ClubbingParameterMaster
           (ClubbingParameterName
           ,ClubbingParameterCode
		   ,Active
           ,CreatedBy
           ,CreatedAt)
          
     VALUES
           (@P_ClubbingParameterName
           ,@P_ClubbingParameterCode
		   ,@P_Active
           ,@P_CreatedBy
		   ,GetDate()
           );

	Select @V_Id = @@IDENTITY;
	SET @V_SubAction='SAVE';
	end
Else
begin

SELECT @V_Name= ClubbingParameterName, @V_Code =ClubbingParameterCode,@V_Active= Active from 
[dbo].ClubbingParameterMaster WHERE ClubbingParameterID=@P_Id;


UPDATE ClubbingParameterMaster

   SET ClubbingParameterName = @P_ClubbingParameterName
      ,ClubbingParameterCode = @P_ClubbingParameterCode
	  ,Active=@P_Active
      ,UpdatedBy = @P_CreatedBy
      ,UpdatedAt = GetDate()
     
 WHERE ClubbingParameterID=@P_Id; 

 Select @V_Id = @P_Id;

 SET @V_SubAction='UPDATE';
 IF @V_Name!=@P_ClubbingParameterName
		SET @V_LogDescription =  'ClubbingParameterName= '+@V_Name+' -> '+@P_ClubbingParameterName;
 

	IF @V_Code!=@P_ClubbingParameterCode
		SET @V_LogDescription =@V_LogDescription + ', ClubbingParametersCode= '+@V_Code+' -> '+@P_ClubbingParameterCode;

	IF @V_Active!=@P_Active
		SET @V_LogDescription =@V_LogDescription + ', Active= '+CAST( @V_Active as varchar(10)) +' -> '+CAST( @P_Active as varchar(10));
 end

  Exec LogActivity 'ClubbingParameterMaster',@V_SubAction,@V_Id,@V_LogDescription,@P_CreatedBy;

 Select @V_Id;
 
END
