--- YOU MUST EXECUTE THE FOLLOWING SCRIPT IN SQLCMD MODE.

-- Values you may need to change for your lab
-- Primary replica: SQLSERVER-0
-- Secondary replica: SQLSERVER-1
-- Backup Central Share: \\CLUSTER-FSW\SQLBACKUPS

 ---------------------------------------------------------
 -- Create the Extended Events session on the SQLSERVER-0
 ---------------------------------------------------------
:Connect SQLSERVER-0
CREATE EVENT SESSION [AlwaysOn_AutoseedMonitor] ON SERVER 
ADD EVENT sqlserver.error_reported(
    WHERE ([severity]=(16))),
ADD EVENT sqlserver.hadr_automatic_seeding_failure,
ADD EVENT sqlserver.hadr_automatic_seeding_start,
ADD EVENT sqlserver.hadr_automatic_seeding_success,
ADD EVENT sqlserver.hadr_physical_seeding_progress
ADD TARGET package0.event_file(SET filename=N'AlwaysOn_AutoseedMonitor'),
ADD TARGET package0.ring_buffer(SET max_memory=(256000))
WITH (
    MAX_MEMORY=4096 KB
    ,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS
    ,MAX_DISPATCH_LATENCY=30 SECONDS
    ,MAX_EVENT_SIZE=0 KB
    ,MEMORY_PARTITION_MODE=NONE
    ,TRACK_CAUSALITY=OFF
    ,STARTUP_STATE=ON
)
GO
ALTER EVENT SESSION [AlwaysOn_AutoseedMonitor] ON SERVER  
STATE = START  
GO

 ---------------------------------------------------------
 -- Create the Extended Events session on the SQLSERVER-1
 ---------------------------------------------------------
:Connect SQLSERVER-1
CREATE EVENT SESSION [AlwaysOn_AutoseedMonitor] ON SERVER 
ADD EVENT sqlserver.error_reported(
    WHERE ([severity]=(16))),
ADD EVENT sqlserver.hadr_automatic_seeding_failure,
ADD EVENT sqlserver.hadr_automatic_seeding_start,
ADD EVENT sqlserver.hadr_automatic_seeding_success,
ADD EVENT sqlserver.hadr_physical_seeding_progress
ADD TARGET package0.event_file(SET filename=N'AlwaysOn_AutoseedMonitor'),
ADD TARGET package0.ring_buffer(SET max_memory=(256000))
WITH (
    MAX_MEMORY=4096 KB
    ,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS
    ,MAX_DISPATCH_LATENCY=30 SECONDS
    ,MAX_EVENT_SIZE=0 KB
    ,MEMORY_PARTITION_MODE=NONE
    ,TRACK_CAUSALITY=OFF
    ,STARTUP_STATE=ON
)
GO
ALTER EVENT SESSION [AlwaysOn_AutoseedMonitor] ON SERVER  
STATE = START  
GO

 ---------------------------------------------------------
 -- Clean up steps
 ---------------------------------------------------------
:Connect SQLSERVER-0
DROP EVENT SESSION [AlwaysOn_AutoseedMonitor] ON SERVER 
GO
:Connect SQLSERVER-1
DROP EVENT SESSION [AlwaysOn_AutoseedMonitor] ON SERVER 
GO
