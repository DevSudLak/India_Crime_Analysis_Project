-- /////////////////////////////////////////////////////////////////
-- Table Name      : bronze.CrimeReports
-- Purpose         : Staging (Bronze) layer table for raw crime data
-- Description     : 
--     This table stores raw crime records directly ingested from 
--     external CSV files. It acts as a landing zone for unprocessed data 
--     with no transformations applied.
--     Date fields are intentionally stored as VARCHAR to prevent type 
--     conflicts during ingestion. Proper datatype conversions are handled 
--     in the Silver layer.
-- /////////////////////////////////////////////////////////////////

IF OBJECT_ID('bronze.CrimeReports', 'U') IS NOT NULL
    DROP TABLE bronze.CrimeReports;
GO

CREATE TABLE [bronze].[CrimeReports]
(
    Report_Number        INT             NOT NULL,
    Date_Reported        VARCHAR(50)     NOT NULL, -- Stored as string to avoid parse errors
    Date_of_Occurrence   VARCHAR(50)     NOT NULL, -- Will be converted to DATE in Silver layer
    Time_of_Occurrence   VARCHAR(50)     NOT NULL,
    City                 NVARCHAR(50)    NOT NULL,
    Crime_Code           SMALLINT        NOT NULL,
    Crime_Description    NVARCHAR(50)    NOT NULL,
    Victim_Age           TINYINT         NOT NULL,
    Victim_Gender        NVARCHAR(50)    NOT NULL,
    Weapon_Used          NVARCHAR(50)    NOT NULL,
    Crime_Domain         NVARCHAR(50)    NOT NULL,
    Police_Deployed      TINYINT         NOT NULL,
    Case_Closed          VARCHAR(10)     NOT NULL,
    Date_Case_Closed     VARCHAR(50)     NULL       -- Nullable in case case not closed
);
GO
