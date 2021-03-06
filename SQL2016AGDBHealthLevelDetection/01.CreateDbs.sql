--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.
:Connect SQLSERVER-0

USE master
GO

-- CorruptDb
CREATE DATABASE [CorruptDb] CONTAINMENT = NONE
ON PRIMARY (NAME = N'CorruptDb_data', FILENAME = N'F:\DATA\CorruptDb_data.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
LOG ON ( NAME = N'CorruptDb_log', FILENAME = N'F:\LOG\CorruptDb_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [CorruptDb] SET COMPATIBILITY_LEVEL = 130
GO
ALTER DATABASE [CorruptDb] SET PAGE_VERIFY CHECKSUM  
GO
USE [CorruptDb]
GO
CREATE TABLE [dbo].[DemoData] (id INT IDENTITY PRIMARY KEY, demoData VARCHAR(200));
GO
INSERT INTO [dbo].[DemoData] (demoData) VALUES ('Test data prior to simulating page level corruption');
GO 200

-- SuspectDb (NOTE: G:\ for TransLog)
CREATE DATABASE [SuspectDb] CONTAINMENT = NONE
ON PRIMARY (NAME = N'SuspectDb_data', FILENAME = N'F:\DATA\SuspectDb_data.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
LOG ON ( NAME = N'SuspectDb_log', FILENAME = N'G:\LOG\SuspectDb_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [SuspectDb] SET COMPATIBILITY_LEVEL = 130
GO
ALTER DATABASE [SuspectDb] SET PAGE_VERIFY CHECKSUM  
GO
USE [SuspectDb]
GO
CREATE TABLE [dbo].[DemoData] (id INT IDENTITY PRIMARY KEY, demoData VARCHAR(200));
GO
INSERT INTO [dbo].[DemoData] (demoData) VALUES ('Test data prior to making the database suspect');
GO 200


