--
--  Project URL:   https://github.com/matticusau/sqldemos
--  Purpose:       Demonstration
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

-- Just query a system table to generate a connection in the database
while 1=1
BEGIN
	select * from sys.tables
	WAITFOR DELAY '00:00:05'
END

