--
--  Project URL:   https://github.com/matticusau/sqldemos
--  Purpose:       Demonstrate database full files
--  SQL Version:   SQL 2005 and above
--  Disclaimer:    This code and information are provided "AS IS" without warranty of any kind, either expressed or implied. 
-- 
--  History
--  When        Version     Who         What
--  -----------------------------------------------------------------
--  27/06/2018  0.1.0       matticusau  Initial coding
--  -----------------------------------------------------------------
--

-- set context
USE master
GO

-- Create the DB
IF EXISTS (SELECT [name] from [sys].[databases] WHERE [name] = N'DemoDb')
BEGIN
    DROP DATABASE [DemoDb];
END
CREATE DATABASE [DemoDb] 
    ON PRIMARY ( NAME = N'DemoDb_data', FILENAME = N'F:\Data\DemoDb_data.mdf' , SIZE = 8192KB, FILEGROWTH = 0 )
    LOG ON ( NAME = N'DemoDb_log', FILENAME = N'F:\Data\DemoDb_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO

-- NOTE: if the db is in use then kill connections (only in a lab scenario)
-- SELECT 'KILL '+CONVERT(VARCHAR(10), session_id) FROM sys.dm_exec_sessions WHERE database_id = DB_ID('DemoDb')
