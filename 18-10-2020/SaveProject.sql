USE [DB_A6523C_finapp]
GO
/****** Object:  StoredProcedure [dbo].[SaveProject]    Script Date: 17-10-2020 06:22:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[SaveProject] @P_Id int,
@P_ProjectType varchar(50),
@P_ManualProjectCode varchar(10),@P_ProjectName varchar(250),
@P_ProjectSegmentCode varchar(5) = null,@P_ProjectEntityCode varchar(5) = null,
@P_BUCategoryCode varchar(5) = null,@P_StatutoryCategoryCode varchar(5) = null,
@P_CountryCode varchar(5) null,@P_BillingTypesCode varchar(5) null,
@P_ContractTypeCode varchar(5) null,@P_ContractStatusCode varchar(5) null,
@P_SmartViewCode varchar(5) null,@P_GroupingParametersCode varchar(5) null,
@P_ManagementCategoryCode varchar(5) null,@P_Notes varchar(3000) null,
@P_ProjectStatus varchar(20),@P_CreatedBy varchar(50)

	
AS
BEGIN
Declare @V_Id int = 0;
Declare @V_SubAction varchar(100);
Declare @V_ProjectType varchar(50);
--Declare @V_IFSProjectCode varchar(5);
Declare @V_ManualProjectCode varchar(10);
Declare @V_ProjectName varchar(200);
Declare @V_ProjectSegmentCode varchar(5);
Declare @V_ProjectEntityCode varchar(5);
Declare @V_BUCategoryCode varchar(5);
Declare @V_StatutoryCategoryCode varchar(5);
Declare @V_CountryCode varchar(5);
Declare @V_BillingTypesCode varchar(5);
Declare @V_ContractTypeCode varchar(5);
Declare @V_ContractStatusCode varchar(5);
Declare @V_SmartViewCode varchar(5);
Declare @V_GroupingParametersCode varchar(5);
Declare @V_ManagementCategoryCode varchar(5);
Declare @V_Notes varchar(250);
Declare @V_ProjectStatus varchar(20);
Declare @V_LogDescription varchar(3000) ;
Declare @V_Active bit ;
Declare @V_IsSuccess int=1;
Declare @V_Count int=0;
Declare @V_Message varchar(250)='Success';



Select @V_Active =  Active from ProjectSegmentMaster where ProjectSegmentCode = @P_ProjectSegmentCode;
If (@V_Active = 0) and (@P_ProjectSegmentCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'ProjectSegmentCode is not Active';
End;
Select @V_Active =  Active from ProjectEntityMaster where ProjectEntityCode = @P_ProjectEntityCode;
If (@V_Active = 0) and (@P_ProjectEntityCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'ProjectEntityCode is not Active';
End;
Select @V_Active =  Active from BUCategoryMaster where BUCategoryCode = @P_BUCategoryCode;
If (@V_Active = 0) and (@P_BUCategoryCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'BUCategoryCode is not Active';
End;
Select @V_Active =  Active from StatutoryCategoryMaster where StatutoryCategoryCode = @P_StatutoryCategoryCode;
If (@V_Active = 0) and (@P_StatutoryCategoryCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'StatutoryCategoryCode is not Active';
End;
Select @V_Active =  Active from CountryMaster where CountryCode = @P_CountryCode;
If (@V_Active = 0) and (@P_CountryCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'CountryCode is not Active';
End;
Select @V_Active =  Active from BillingTypesMaster where BillingTypeCode = @P_BillingTypesCode;
If (@V_Active = 0) and (@P_BillingTypesCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'BillingTypeCode is not Active';
End;
Select @V_Active =  Active from ContractTypeMaster where ContractTypeCode = @P_ContractTypeCode;
If (@V_Active = 0)and (@P_ContractTypeCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'ContractTypeCode is not Active';
End;
Select @V_Active =  Active from ContractStatusMaster where ContractStatusCode = @P_ContractStatusCode;
If (@V_Active = 0) and (@P_ContractStatusCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'ContractStatusCode is not Active'
End;
Select @V_Active =  Active from SmartViewCodeMaster where SmartViewCode = @P_SmartViewCode;
If (@V_Active = 0) and (@P_SmartViewCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'SmartViewCode is not Active';
End;
Select @V_Active =  Active from GroupingParametersMaster where GroupingParametersCode = @P_GroupingParametersCode;
If (@V_Active = 0) and (@P_GroupingParametersCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'GroupingParametersCode is not Active';
End;
Select @V_Active =  Active from ManagementCategoryMaster where ManagementCategoryCode = @P_ManagementCategoryCode;
If (@V_Active = 0) and (@P_ManagementCategoryCode <> ' ')
Begin
Set @V_IsSuccess = 0;
Set @V_Message = 'ManagementCategoryCode is not Active';
End;


If (@V_IsSuccess = 1)
Begin
If (@P_Id = 0)
begin
Select @V_Count = count(1) from Project where ManualProjectCode = @P_ManualProjectCode;
If (@V_Count = 0)
Begin
INSERT INTO [dbo].[Project]
           ([ProjectType]
           --,[IFSProjectCode]
           ,[ManualProjectCode]
           ,[ProjectName]
           ,[ProjectSegmentCode]
           ,[ProjectEntityCode]
           ,[BUCategoryCode]
           ,[StatutoryCategoryCode]
           ,[CountryCode]
           ,[BillingTypesCode]
           ,[ContractTypeCode]
           ,[ContractStatusCode]
           ,[SmartViewCode]
           ,[GroupingParametersCode]
           ,[ManagementCategoryCode]
           ,[Notes]
           ,[CreatedBy]
           ,[CreatedAt]
           )
     VALUES
           (@P_ProjectType
           --,@P_IFSProjectCode
           ,@P_ManualProjectCode
           ,@P_ProjectName
           ,@P_ProjectSegmentCode
           ,@P_ProjectEntityCode
           ,@P_BUCategoryCode
           ,@P_StatutoryCategoryCode
           ,@P_CountryCode
           ,@P_BillingTypesCode
           ,@P_ContractTypeCode
           ,@P_ContractStatusCode
           ,@P_SmartViewCode
           ,@P_GroupingParametersCode
           ,@P_ManagementCategoryCode
           ,@P_Notes
           ,@P_CreatedBy
           ,getdate()
           )

	Select @V_Id = @@IDENTITY;
	SET @V_SubAction='SAVE';
	end
	else
 begin
 Set @V_Message = 'Duplicate Manual Project Code';
 end;
	End
Else
begin
 
SELECT @V_ProjectType = [ProjectType]
      --,@V_IFSProjectCode = [IFSProjectCode]
      ,@V_ManualProjectCode = [ManualProjectCode]
      ,@V_ProjectName = [ProjectName]
      ,@V_ProjectSegmentCode = [ProjectSegmentCode]
      ,@V_ProjectEntityCode = [ProjectEntityCode]
      ,@V_BUCategoryCode = [BUCategoryCode]
      ,@V_StatutoryCategoryCode = [StatutoryCategoryCode]
      ,@V_CountryCode = [CountryCode]
      ,@V_BillingTypesCode = [BillingTypesCode]
      ,@V_ContractTypeCode = [ContractTypeCode]
      ,@V_ContractStatusCode = [ContractStatusCode]
      ,@V_SmartViewCode = [SmartViewCode]
      ,@V_GroupingParametersCode = [GroupingParametersCode]
      ,@V_ManagementCategoryCode = [ManagementCategoryCode]
      ,@V_Notes = [Notes]
      ,@V_ProjectStatus = [ProjectStatus]
	  FROM [dbo].[Project]
	   WHERE ProjectID = @P_Id; 
	   set @V_Count=0;
If (@P_ManualProjectCode != @V_ManualProjectCode)
Begin
Select @V_Count = count(1) from Project where ManualProjectCode = @P_ManualProjectCode
End;

If (@V_Count = 0)
Begin
UPDATE [dbo].[Project]
   SET [ProjectType] = @P_ProjectType
      --,[IFSProjectCode] = @P_IFSProjectCode
      ,[ManualProjectCode] = @P_ManualProjectCode
      ,[ProjectName] = @P_ProjectName
      ,[ProjectSegmentCode] = @P_ProjectSegmentCode
      ,[ProjectEntityCode] = @P_ProjectEntityCode
      ,[BUCategoryCode] = @P_BUCategoryCode
      ,[StatutoryCategoryCode] = @P_StatutoryCategoryCode
      ,[CountryCode] = @P_CountryCode
      ,[BillingTypesCode] = @P_BillingTypesCode
      ,[ContractTypeCode] = @P_ContractTypeCode
      ,[ContractStatusCode] = @P_ContractStatusCode
      ,[SmartViewCode] = @P_SmartViewCode
      ,[GroupingParametersCode] = @P_GroupingParametersCode
      ,[ManagementCategoryCode] = @P_ManagementCategoryCode
      ,[Notes] = @P_Notes
      ,[ProjectStatus] =  @P_ProjectStatus
      ,[UpdatedBy] = @P_CreatedBy
      ,[UpdatedAt] = getdate()
 WHERE ProjectID = @P_Id; 
  
 Select @V_Id = @P_Id;
 SET @V_SubAction='UPDATE';
IF @V_ProjectType!=@P_ProjectType
	SET @V_LogDescription =  '[ProjectType]= '+@V_ProjectType+' -> '+@P_ProjectType;
--IF @V_IFSProjectCode!=@P_IFSProjectCode
--	SET @V_LogDescription =@V_LogDescription + ', [IFSProjectCode]= '+@V_IFSProjectCode+' -> '+@P_IFSProjectCode;
IF @V_ManualProjectCode!=@P_ManualProjectCode
	SET @V_LogDescription =@V_LogDescription + ', [ManualProjectCode]= '+@V_ManualProjectCode+' -> '+@P_ManualProjectCode;	
IF @V_ProjectName!=@P_ProjectName
	SET @V_LogDescription =@V_LogDescription + ', [ProjectName]= '+@V_ProjectName+' -> '+@P_ProjectName;
IF @V_ProjectSegmentCode!=@P_ProjectSegmentCode
	SET @V_LogDescription =@V_LogDescription + ', [ProjectSegmentCode]= '+@V_ProjectSegmentCode+' -> '+@P_ProjectSegmentCode;
IF @V_ProjectEntityCode!=@P_ProjectEntityCode
	SET @V_LogDescription =@V_LogDescription + ', [ProjectEntityCode]= '+@V_ProjectEntityCode+' -> '+@P_ProjectEntityCode;	
IF @V_BUCategoryCode!=@P_BUCategoryCode
	SET @V_LogDescription =@V_LogDescription + ', [BUCategoryCode]= '+@V_BUCategoryCode+' -> '+@P_BUCategoryCode;	
IF @V_StatutoryCategoryCode!=@P_StatutoryCategoryCode
	SET @V_LogDescription =@V_LogDescription + ', [StatutoryCategoryCode]= '+@V_StatutoryCategoryCode+' -> '+@P_StatutoryCategoryCode;
IF @V_CountryCode!=@P_CountryCode
	SET @V_LogDescription =@V_LogDescription + ', [CountryCode]= '+@V_CountryCode+' -> '+@P_CountryCode;	
IF @V_BillingTypesCode!=@P_BillingTypesCode
	SET @V_LogDescription =@V_LogDescription + ', [BillingTypesCode]= '+@V_BillingTypesCode+' -> '+@P_BillingTypesCode;	
IF @V_ContractTypeCode!=@P_ContractTypeCode
	SET @V_LogDescription =@V_LogDescription + ', [ContractTypeCode]= '+@V_ContractTypeCode+' -> '+@P_BUCategoryCode;	
IF @V_ContractStatusCode!=@P_ContractTypeCode
	SET @V_LogDescription =@V_LogDescription + ', [ContractStatusCode]= '+@V_ContractStatusCode+' -> '+@P_ContractTypeCode;	
IF @V_SmartViewCode!=@P_SmartViewCode
	SET @V_LogDescription =@V_LogDescription + ', [SmartViewCode]= '+@V_SmartViewCode+' -> '+@P_SmartViewCode;	
IF @V_GroupingParametersCode!=@P_GroupingParametersCode
	SET @V_LogDescription =@V_LogDescription + ', [GroupingParametersCode]= '+@V_GroupingParametersCode+' -> '+@P_GroupingParametersCode;
IF @V_ManagementCategoryCode!=@P_ManagementCategoryCode
	SET @V_LogDescription =@V_LogDescription + ', [ManagementCategoryCode]= '+@V_ManagementCategoryCode+' -> '+@P_ManagementCategoryCode;
IF @V_Notes!=@P_Notes
	SET @V_LogDescription =@V_LogDescription + ', [Notes]= '+@V_Notes+' -> '+@P_Notes;
IF @V_ProjectStatus!=@P_ProjectStatus
	SET @V_LogDescription =@V_LogDescription + ', [ProjectStatus]= '+@V_ProjectStatus+' -> '+@P_ProjectStatus;

 end
 else
 begin
 Set @V_Message = 'Duplicate Manual Project Code';
 end;
end
  Exec LogActivity 'Action',@V_SubAction,@V_Id,@V_LogDescription,@P_CreatedBy;


 End
  Select @V_Message,@V_Id;
END
