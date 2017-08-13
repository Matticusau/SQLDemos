--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.

-- Add the database to the AG on the Primary
:Connect SQLSERVER-0
USE [master]
GO
ALTER AVAILABILITY GROUP [DbHealthOptDemoAg]
MODIFY REPLICA ON N'SQLSERVER-1' WITH (SEEDING_MODE = AUTOMATIC)
GO
USE [master]
GO
ALTER AVAILABILITY GROUP [DbHealthOptDemoAg]
ADD DATABASE [CorruptDb];
GO

-- Make sure the secondary is set to Auto Seed with CREATE DB permissions
:Connect SQLSERVER-1
ALTER AVAILABILITY GROUP [DbHealthOptDemoAg] GRANT CREATE ANY DATABASE;
GO


-- if auto seeding doesn't automatically work, check the logs as if you haven't cleaned up
-- the data and log files from previous demos they may prevent the auto seeding.

-- The following statements can be used if AUTO Seeding doesn't run (once the issue is resolved)
:Connect SQLSERVER-0
BACKUP DATABASE [CorruptDb] TO DISK = N'\\CLUSTER-FSW\SQLBACKUPS\CorruptDb_addtoAG.bak' WITH FORMAT;  
GO
 :Connect SQLSERVER-1
RESTORE DATABASE [CorruptDb] FROM DISK = N'\\CLUSTER-FSW\SQLBACKUPS\CorruptDb_addtoAG.bak' WITH NORECOVERY;
GO 
:Connect SQLSERVER-0 
BACKUP LOG [CorruptDb] TO DISK = N'\\CLUSTER-FSW\SQLBACKUPS\CorruptDb_addtoAG.trn' WITH FORMAT;
GO  
:Connect SQLSERVER-1
RESTORE LOG [CorruptDb] FROM DISK = N'\\CLUSTER-FSW\SQLBACKUPS\CorruptDb_addtoAG.trn' WITH NORECOVERY;  
GO
ALTER DATABASE [CorruptDb] SET HADR AVAILABILITY GROUP = [DbHealthOptDemoAg];  
GO  

