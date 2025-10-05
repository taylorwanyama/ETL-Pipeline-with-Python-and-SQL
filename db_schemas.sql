/* 
This script initializes the core database environment for a Bike Sales Data Warehouse project
following the standard Medallion Architecture (Bronze, Silver, Gold Layers).

The script performs the following critical setup steps:
1. **Database Management:** Checks for, drops, and recreates the primary database, 'ETL_DataWarehouse', 
   ensuring a clean starting environment.
2. **Schema Definition:** Creates the three dedicated schemas (Bronze, Silver, Gold) which will logically 
   separate the data layers based on their cleanliness and transformation status.

LAYER DEFINITIONS:
- **Bronze:** Stores raw, uncleaned, and source-aligned data (e.g., Bike_Sales_2021, Bike_Sales_2022).
- **Silver:** Stores clean, conformed, and standardized data.
- **Gold:** Stores highly integrated, aggregated, and query-ready data for reporting and BI tools.
*/

USE master;

-- Drops and then recreate a the database if it exists
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'ETL_DataWarehouse')
BEGIN
    ALTER DATABASE ETL_DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ETL_DataWarehouse;
END

-- Create the ETL warehouse database
CREATE DATABASE ETL_DataWarehouse;

-- Use the newly created database
USE ETL_DataWarehouse;

-- creating the Bronze schema
CREATE SCHEMA Bronze;
GO
-- Create Silver schema
CREATE SCHEMA Silver;
GO
-- Create Gold schema
CREATE SCHEMA Gold;
GO

