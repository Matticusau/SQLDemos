--
--  Project URL:   https://github.com/matticusau/sqldemos
--  Purpose:       Demonstrate different VLF levels by generate test data
--  SQL Version:   SQL 2005 and above
--  Disclaimer:    This code and information are provided "AS IS" without warranty of any kind, either expressed or implied. 
-- 
--  History
--  When        Version     Who         What
--  -----------------------------------------------------------------
--  27/06/2018  0.1.0       matticusau  Initial coding
--  -----------------------------------------------------------------
--

-- Create and configure the database
IF EXISTS (SELECT [name] from [sys].[databases] WHERE [name] = N'VlfDemo')
BEGIN
    DROP DATABASE [VlfDemo];
END
CREATE DATABASE [VlfDemo] 
    ON PRIMARY ( NAME = N'VlfDemo_data', FILENAME = N'F:\Data\VlfDemo_data.mdf' , SIZE = 51200KB , FILEGROWTH = 65536KB )
    LOG ON ( NAME = N'VlfDemo_log', FILENAME = N'F:\Log\VlfDemo_log.ldf' , SIZE = 51200KB , FILEGROWTH = 10% )
GO

-- NOTE: if the db is in use then kill connections (only in a lab scenario)
-- SELECT 'KILL '+CONVERT(VARCHAR(10), session_id) FROM sys.dm_exec_sessions WHERE database_id = DB_ID('VlfDemo')

-- Set context
USE [VlfDemo]
GO

-- Create a table
IF EXISTS(SELECT [name] FROM [sys].[tables] WHERE [name] = N'demoTable')
BEGIN
    DROP TABLE [dbo].[demoTable];
END
GO
CREATE TABLE [dbo].[demoTable]
(
    [id] INT IDENTITY(1,1) PRIMARY KEY
    , [textField] VARCHAR(250)
)
GO

-- Grow the database
INSERT INTO [dbo].[demoTable] ([textField]) 
VALUES ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 1')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 2')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 3')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 4')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 5')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 6')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 7')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 8')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 9')
, ('This insert of data is to a test table which is designed to grow the database through auto-growth and demonstrate VLF fragmentation. Line 10')
GO 10000

