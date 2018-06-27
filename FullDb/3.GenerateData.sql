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

-- Set context
USE [DemoDb]
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
GO 500
CHECKPOINT
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
GO 500

