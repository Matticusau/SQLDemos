--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.

-- Generate the Logical Consistency check error
:Connect SQLSERVER-0
DBCC DROPCLEANBUFFERS
GO
USE [CorruptDb]
GO
SELECT * FROM [dbo].[DemoData];
GO
