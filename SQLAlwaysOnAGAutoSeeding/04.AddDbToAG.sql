--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.

-- Values you may need to change for your lab
-- Primary replica: SQLSERVER-0
-- Secondary replica: SQLSERVER-1
-- Backup Central Share: \\CLUSTER-FSW\SQLBACKUPS

 ---------------------------------------------------------
 -- Add the 2nd database to the AG
 ---------------------------------------------------------
:Connect SQLSERVER-0
USE [master]
GO
ALTER AVAILABILITY GROUP [DbAutoseedDemoAg]
MODIFY REPLICA ON N'SQLSERVER-1' WITH (SEEDING_MODE = AUTOMATIC)
GO
USE [master]
GO
ALTER AVAILABILITY GROUP [DbAutoseedDemoAg]
ADD DATABASE [AutoseedDb02];
GO

 ---------------------------------------------------------
 -- Make sure the secondary replica is allowed to create the db (allow for seeding)
 ---------------------------------------------------------
:Connect SQLSERVER-1
ALTER AVAILABILITY GROUP [DbAutoseedDemoAg] GRANT CREATE ANY DATABASE;
GO




---------------------------------------------------------
-- NOTE: At this point Automatic Seeding should have attempted 
-- to replicate the database but failed due to the drive paths mismatch
---------------------------------------------------------

  
-- CLEANUP SCRIPT
-- uncomment below TSQL statements and execute it to delete the availability group and the availability databases
--:Connect SQLSERVER-0
--DROP AVAILABILITY GROUP [DbAutoseedDemoAg];
--DROP DATABASE [AutoseedDb01];
--DROP DATABASE [AutoseedDb02];
--GO

--:Connect SQLSERVER-1
--DROP DATABASE [AutoseedDb01];
--DROP DATABASE [AutoseedDb02];
--GO