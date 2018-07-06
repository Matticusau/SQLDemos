--
--  Project URL:   https://github.com/matticusau/sqldemos
--  Purpose:       Demonstrate blocking locks - setup and transaction
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
IF EXISTS(SELECT [name] FROM [sys].[tables] WHERE [name] = N'blockerTable')
BEGIN
    DROP TABLE [dbo].[blockerTable];
END
GO
CREATE TABLE [dbo].[blockerTable]
(
    [id] INT PRIMARY KEY
    , [textField] VARCHAR(250)
)
GO
INSERT INTO [dbo].[blockerTable] ([id], [textField]) VALUES (1, 'A test record');
GO
BEGIN TRAN
UPDATE [dbo].[blockerTable] SET [textField] = 'Update test' WHERE [id] = 1;

-- ROLLBACK TRAN
-- COMMIT TRAN

