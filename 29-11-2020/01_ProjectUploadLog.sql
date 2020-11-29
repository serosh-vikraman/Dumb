 
CREATE TABLE [dbo].[ProjectUploadLog](
	[SessionID] [varchar](250) NULL,
	[RowNumber] [int] NULL,
	[ColumnNumber] [int] NULL,
	[Status] [varchar](25) NULL,
	[Message] [varchar](2500) NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedAt] [datetime] NULL,
	[ErrorCode] [varchar](25) NULL
) ON [PRIMARY]
GO


