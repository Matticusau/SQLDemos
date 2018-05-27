-- Create pbiuser login for PowerBi training
CREATE USER [pbiuser]
	WITH PASSWORD = '##########'
	, DEFAULT_SCHEMA = [dbo]
GO

-- Add user to the database owner role
EXEC sp_addrolemember N'db_datareader', N'pbiuser'
GO
