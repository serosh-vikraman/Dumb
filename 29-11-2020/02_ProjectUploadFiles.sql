 
CREATE TABLE [dbo].[ProjectUploadFiles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [varchar](500) NULL,
	[FileName] [varchar](500) NULL,
	[FilePath] [varchar](500) NULL,
	[Status] [varchar](50) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[Message] [varchar](2000) NULL,
 CONSTRAINT [PK_ProjectUploadFiles] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


