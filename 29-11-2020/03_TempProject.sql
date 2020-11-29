 

CREATE TABLE [dbo].[TempProject](
	[TempProjectID] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [varchar](250) NULL,
	[RowNum] [int] NULL,
	[IFSProjectCode] [varchar](15) NULL,
	[ManualProjectCode] [varchar](15) NULL,
	[ProjectName] [varchar](250) NULL,
	[ProjectSegmentName] [varchar](500) NULL,
	[ProjectEntityName] [varchar](500) NULL,
	[BUCategoryName] [varchar](500) NULL,
	[StatutoryCategoryName] [varchar](500) NULL,
	[CountryName] [varchar](500) NULL,
	[BillingTypesName] [varchar](500) NULL,
	[ContractTypeName] [varchar](500) NULL,
	[ContractStatusName] [varchar](500) NULL,
	[SmartViewName] [varchar](500) NULL,
	[GroupingParametersName] [varchar](500) NULL,
	[ManagementCategoryName] [varchar](500) NULL,
	[ProjectSegmentCode] [varchar](5) NULL,
	[ProjectEntityCode] [varchar](5) NULL,
	[BUCategoryCode] [varchar](5) NULL,
	[StatutoryCategoryCode] [varchar](5) NULL,
	[CountryCode] [varchar](5) NULL,
	[BillingTypesCode] [varchar](5) NULL,
	[ContractTypeCode] [varchar](5) NULL,
	[ContractStatusCode] [varchar](5) NULL,
	[SmartViewCode] [varchar](5) NULL,
	[GroupingParametersCode] [varchar](5) NULL,
	[ManagementCategoryCode] [varchar](5) NULL,
	[Notes] [varchar](3000) NULL,
	[Message] [varchar](3000) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[Projectstatus] [varchar](50) NULL,
	[ProjectType] [varchar](50) NULL,
	[ClubbingParameterName] [varchar](500) NULL,
	[ClubbingParameterCode] [varchar](5) NULL,
 CONSTRAINT [PK_TempProject] PRIMARY KEY CLUSTERED 
(
	[TempProjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


