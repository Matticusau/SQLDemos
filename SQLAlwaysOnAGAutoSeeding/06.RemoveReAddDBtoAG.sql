--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.

 ---------------------------------------------------------
 -- Remove the DBs from the AG
 ---------------------------------------------------------
:Connect SQLSERVER-0
ALTER AVAILABILITY GROUP [DbAutoseedDemoAg] REMOVE DATABASE [AutoseedDb01];
ALTER AVAILABILITY GROUP [DbAutoseedDemoAg] REMOVE DATABASE [AutoseedDb02];


 ---------------------------------------------------------
 -- Drop the DB on the secondary
 ---------------------------------------------------------
:Connect SQLSERVER-1
DROP DATABASE [AutoseedDb01];


 ---------------------------------------------------------
 -- Create a transaction in the database before we add it back in
 -- this invalidates what is already on the replica
 -- and cause a refresh of the data
 ---------------------------------------------------------
 :Connect SQLSERVER-0
USE [AutoseedDb01]
GO
INSERT INTO [dbo].[DemoData] (demoData) VALUES ('Test data prior to re-configuring AG membership');
GO 200

 ---------------------------------------------------------
 -- Add the DB back into the AG
 ---------------------------------------------------------
 :Connect SQLSERVER-0
USE [master]
GO
ALTER AVAILABILITY GROUP [DbAutoseedDemoAg]
ADD DATABASE [AutoseedDb01];
GO