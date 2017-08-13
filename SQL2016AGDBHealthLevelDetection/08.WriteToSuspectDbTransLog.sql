--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.

:Connect SQLSERVER-0
USE [SuspectDb]
GO
INSERT INTO [dbo].[DemoData] (demoData) VALUES ('Data to push through the TransLog');
GO
