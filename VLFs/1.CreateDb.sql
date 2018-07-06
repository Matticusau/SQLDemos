--
--  Project URL:   https://github.com/matticusau/sqldemos
--  Purpose:       Demonstrate different VLF levels
--  SQL Version:   SQL 2005 and above
--  Disclaimer:    This code and information are provided "AS IS" without warranty of any kind, either expressed or implied. 
-- 
--  History
--  When        Version     Who         What
--  -----------------------------------------------------------------
--  27/06/2018  0.1.0       matticusau  Initial coding
--  -----------------------------------------------------------------
--

-- Create the DB with 65mb log auto growth
IF EXISTS (SELECT [name] from [sys].[databases] WHERE [name] = N'VlfDemo')
BEGIN
    DROP DATABASE [VlfDemo];
END
CREATE DATABASE [VlfDemo] 
    ON PRIMARY ( NAME = N'VlfDemo_data', FILENAME = N'F:\Data\VlfDemo_data.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
    LOG ON ( NAME = N'VlfDemo_log', FILENAME = N'F:\Log\VlfDemo_log.ldf' , SIZE = 8192KB , FILEGROWTH = 66560KB )
GO

-- NOTE: if the db is in use then kill connections (only in a lab scenario)
-- SELECT 'KILL '+CONVERT(VARCHAR(10), session_id) FROM sys.dm_exec_sessions WHERE database_id = DB_ID('VlfDemo')
