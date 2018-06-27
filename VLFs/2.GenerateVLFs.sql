--
--  Project URL:   https://github.com/matticusau/sqldemos
--  Purpose:       Demonstrate different VLF levels by growing the database
--  SQL Version:   SQL 2005 and above
--  Disclaimer:    This code and information are provided "AS IS" without warranty of any kind, either expressed or implied. 
-- 
--  History
--  When        Version     Who         What
--  -----------------------------------------------------------------
--  27/06/2018  0.1.0       matticusau  Initial coding
--  -----------------------------------------------------------------
--

-- Set context
USE [VlfDemo]
GO

-- Grow the database (1Gb)
DECLARE @fileSize BIGINT = (SELECT size FROM sys.database_files WHERE [name] = N'VlfDemo_log');
DECLARE @growth INT = 8192; -- 8mb
DECLARE @tsql VARCHAR(255);
WHILE (@fileSize <= 1048576)
BEGIN
    SET @fileSize = @fileSize + @growth;
    SET @tsql = 'ALTER DATABASE [VlfDemo] MODIFY FILE ( NAME = N''VlfDemo_log'', SIZE = ' + CONVERT(VARCHAR(20), @fileSize) + 'KB )';
    PRINT (@tsql);
    EXEC (@tsql)
END
GO

-- Grow the database (2Gb)
DECLARE @fileSize BIGINT = (SELECT size FROM sys.database_files WHERE [name] = N'VlfDemo_log');
DECLARE @growth INT = 8192; -- 8mb
DECLARE @tsql VARCHAR(255);
WHILE (@fileSize <= 2097152)
BEGIN
    SET @fileSize = @fileSize + @growth;
    SET @tsql = 'ALTER DATABASE [VlfDemo] MODIFY FILE ( NAME = N''VlfDemo_log'', SIZE = ' + CONVERT(VARCHAR(20), @fileSize) + 'KB )';
    PRINT (@tsql);
    EXEC (@tsql)
END
GO


-- Grow the database (5Gb)
DECLARE @fileSize BIGINT = (SELECT size FROM sys.database_files WHERE [name] = N'VlfDemo_log');
DECLARE @growth INT = 8192; -- 8mb
DECLARE @tsql VARCHAR(255);
WHILE (@fileSize <= 5242880)
BEGIN
    SET @fileSize = @fileSize + @growth;
    SET @tsql = 'ALTER DATABASE [VlfDemo] MODIFY FILE ( NAME = N''VlfDemo_log'', SIZE = ' + CONVERT(VARCHAR(20), @fileSize) + 'KB )';
    PRINT (@tsql);
    EXEC (@tsql);
END
GO
