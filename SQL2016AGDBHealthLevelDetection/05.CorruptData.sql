--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.

-- Credit to Paul Randle for how to use DBCC WRITEPAGE
-- https://www.sqlskills.com/blogs/paul/dbcc-writepage/


-- get the page information of our demo database and table
:Connect SQLSERVER-0
DBCC IND (N'CorruptDb', N'DemoData', -1);
GO

-- Corrup the page data (remember to change the page number)
:Connect SQLSERVER-0
ALTER DATABASE [CorruptDb] SET SINGLE_USER;
GO
DBCC WRITEPAGE (N'CorruptDb', 1, [PageId], 4000, 1, 0x45, 1);
GO
ALTER DATABASE [CorruptDb] SET MULTI_USER;
GO

-- check that we have caused page level corruption, cause a data check
:Connect SQLSERVER-0
DBCC DROPCLEANBUFFERS
GO
USE [CorruptDb]
GO
SELECT * FROM [dbo].[DemoData];
GO
