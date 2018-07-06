--
--  Project URL:   https://github.com/matticusau/sqldemos
--  Purpose:       Demonstrate blocking locks - select against locked record
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

-- try and select the data
BEGIN TRAN
SELECT * FROM [dbo].[blockerTable] WHERE [id] = 1;

-- ROLLBACK TRAN
-- COMMIT TRAN

