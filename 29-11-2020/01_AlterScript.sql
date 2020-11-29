
CREATE TABLE [dbo].[ClubbingParameterMaster](
	[ClubbingParameterID] [int] IDENTITY(1,1) NOT NULL,
	[ClubbingParameterCode] [varchar](5) NOT NULL,
	[ClubbingParameterName] [varchar](100) NOT NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[UpdatedBy] [varchar](50) NULL,
	[UpdatedAt] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_ClubbingParameterMaster] PRIMARY KEY CLUSTERED 
(
	[ClubbingParameterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_ClubbingParameterMaster_ClubbingParameterCode] UNIQUE NONCLUSTERED 
(
	[ClubbingParameterCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ClubbingParameterMaster] ADD  CONSTRAINT [DF_ClubbingParameterMaster_Active]  DEFAULT ((1)) FOR [Active]
GO


ALTER TABLE Project
ADD ClubbingParameterCode varchar(5);
Alter table ClubbingParameterMaster Add Constraint UK_ClubbingParameterMaster_ClubbingParameterCode Unique(ClubbingParameterCode);

ALTER TABLE Project
ADD CONSTRAINT FK_Project_ClubbingParameterCode
FOREIGN KEY (ClubbingParameterCode) REFERENCES ClubbingParameterMaster(ClubbingParameterCode);

INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CPCNA','Clubbing Parameter not active', 'Project', 'Inactive clubbing parameter');

INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CSNSCP','Contract Status should be same as the one used in the Clubbing Parameter.', 'Project', 'Save Error');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('PENSCP','ProjectEntity should be same as the one used in the Clubbing Parameter.', 'Project', 'Save Error');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CSNSCP','Contract Type should be same as the one used in Clubbing Parameter.', 'Project', 'Save Error');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CTNSCP','Contract Status should be same as the one used in the Clubbing Parameter.', 'Project', 'Save Error');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('PSNSCP','Project Segment should be same as the one used in Clubbing Parameter..', 'Project', 'Save Error');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('MCNSCP','Management category should be same asthe one used in Clubbing Parameter..', 'Project', 'Save Error');

INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CPSS','Clubbing Parameter saved successfully.', 'Clubbing Parameter', 'Save Success');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CPNS','Clubbing Parameter could not be saved.', 'Clubbing Parameter', 'Save Error');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CPCNAU','Clubbing Parameter code or name already used.', 'Clubbing Parameter', 'Save Error');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CPNUAUP','Clubbing parameter cannot be updated as it is already used in Project.', 'Clubbing Parameter', 'Save Error');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CPDS','Clubbing parameter deleted Successfully.', 'Clubbing Parameter', 'Delete Success');
INSERT INTO [Messages]
(MessageCode,[Message],[PageName],[Remarks]) VALUES ('CPNDAUP','Clubbing parameter cannot be deleted as it is already used in Project.', 'Clubbing Parameter', 'Delete Error');



CREATE TABLE [dbo].[LegacyInsertion](
	[LegacyInsertionFlag] [bit] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LegacyInsertion] ADD  CONSTRAINT [DF_LegacyInsertion_LegacyInsertionFlag]  DEFAULT ((0)) FOR [LegacyInsertionFlag]
GO


INSERT INTO [dbo].[LegacyInsertion]
           ([LegacyInsertionFlag])
     VALUES
           (0)



