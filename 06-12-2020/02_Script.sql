

CREATE TABLE [dbo].[TempuploadFile](
	[UploadSessionId] [int] NULL,
	[Token] [nvarchar](100) NULL,
	[CreatedOn] [datetime] NULL,
	[FileName] [varchar](500) NULL,
	[UserId] [varchar](50) NULL
) ON [PRIMARY]
GO

