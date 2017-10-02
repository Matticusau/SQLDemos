--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.

-- Values you may need to change for your lab
-- Primary replica: SQLSERVER-0
-- Secondary replica: SQLSERVER-1
-- Backup Central Share: \\CLUSTER-FSW\SQLBACKUPS

---------------------------------------------------------
-- Prereqs for Availability Group
---------------------------------------------------------
:Connect SQLSERVER-0
-- Backup demo databases to share \\CLUSTER-FSW\SQLBACKUPS
BACKUP DATABASE [AutoseedDb01] TO DISK = N'\\CLUSTER-FSW\SQLBACKUPS\AutoseedDb01.bak' WITH FORMAT;  
BACKUP DATABASE [AutoseedDb02] TO DISK = N'\\CLUSTER-FSW\SQLBACKUPS\AutoseedDb02.bak' WITH FORMAT;  
GO  

---------------------------------------------------------
-- AG Endpoints
---------------------------------------------------------
-- If you are using your own lab then you need to create a Database Mirroring end-point
-- The Azure Market Place lab already has the end-point created for you, check these with
 :Connect SQLSERVER-0
SELECT * FROM sys.database_mirroring_endpoints;
GO
  :Connect SQLSERVER-1
SELECT * FROM sys.database_mirroring_endpoints;
GO
-- If you need to create an endpoint use the following syntax
--CREATE ENDPOINT hadr_endpoint  
--    STATE=STARTED   
--    AS TCP (LISTENER_PORT=5022)   
--    FOR DATABASE_MIRRORING (ROLE=ALL);  
--GO  
  
 
---------------------------------------------------------
-- Start the AlwaysOn Extended Events Session
---------------------------------------------------------
-- On the primary replica
:Connect SQLSERVER-0
IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END
GO
-- On the secondary replica
:Connect SQLSERVER-1
IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END
GO


 ---------------------------------------------------------
 -- Create the AG on the primary
 ---------------------------------------------------------
:Connect SQLSERVER-0
USE [master];
CREATE AVAILABILITY GROUP DbAutoseedDemoAg   
	WITH (DB_FAILOVER = ON)
	FOR DATABASE AutoseedDb01
	REPLICA ON
		'SQLSERVER-0' WITH   
			(  
			ENDPOINT_URL = 'TCP://SQLSERVER-0.Contoso.com:5022',  
			AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,  
			FAILOVER_MODE = AUTOMATIC,
			SEEDING_MODE = AUTOMATIC
			),  
		'SQLSERVER-1' WITH   
			(  
			ENDPOINT_URL = 'TCP://SQLSERVER-1.Contoso.com:5022',  
			AVAILABILITY_MODE = SYNCHRONOUS_COMMIT,  
			FAILOVER_MODE = AUTOMATIC,
			SEEDING_MODE = AUTOMATIC
			);   
GO  

 ---------------------------------------------------------
 -- Join the secondary replica to the AG (allow for seeding)
 ---------------------------------------------------------
:Connect SQLSERVER-1
ALTER AVAILABILITY GROUP DbAutoseedDemoAg JOIN;  
GO  
ALTER AVAILABILITY GROUP DbAutoseedDemoAg GRANT CREATE ANY DATABASE;
GO

---------------------------------------------------------
-- NOTE: At this point Automatic Seeding should have replicated
-- the database to the replica as the drive paths match
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