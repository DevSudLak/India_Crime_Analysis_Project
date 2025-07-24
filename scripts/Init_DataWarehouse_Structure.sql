/*
===========================================================================
Script Title   : Initialize Data Warehouse Environment
Purpose        : 
    - Drops the 'DataWarehouse' database if it already exists.
    - Re-creates the database from scratch.
    - Adds structured schemas for staged data processing:
        * bronze  - Raw data layer
        * silver  - Cleansed/processed layer
        * gold    - Analytical/consumption-ready layer

!!! WARNING !!!
    This script will erase the existing 'DataWarehouse' database
    along with all its data. Ensure backups are taken beforehand.
===========================================================================
*/

-- Connect to the master context to manage databases
USE master;
GO

-- Drop existing database if found
IF EXISTS (SELECT * FROM sys.databases WHERE name = N'DataWarehouse')
BEGIN
    PRINT 'Existing DataWarehouse database found. Dropping...';
    ALTER DATABASE [DataWarehouse] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [DataWarehouse];
    PRINT 'Old database dropped successfully.';
END
ELSE
BEGIN
    PRINT 'No existing DataWarehouse database found. Proceeding...';
END
GO

-- Create new database for the data warehouse
CREATE DATABASE [DataWarehouse];
GO
PRINT 'New DataWarehouse database created.';
GO

-- Switch context to the new database
USE [DataWarehouse];
GO

-- Create schemas representing ETL pipeline stages
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'bronze')
    EXEC('CREATE SCHEMA bronze');
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'silver')
    EXEC('CREATE SCHEMA silver');
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'gold')
    EXEC('CREATE SCHEMA gold');
GO

PRINT 'Schemas bronze, silver, and gold successfully created.';
