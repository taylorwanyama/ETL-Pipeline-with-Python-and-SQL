/*
This script establishes the Bronze Layer (raw staging area) for the Bike Sales Data Warehouse. It defines the raw tables for 2021 and 2022 data,
intentionally using VARCHAR for fields that will require type casting (like financial and date columns) to prevent load failures. 
The core function is the stored procedure, Bronze.load_bronze, which uses BULK INSERT to efficiently load the two raw CSV files 
directly from the file system, thereby completing the initial, high-speed ingestion of the source data.
*/
USE ETL_DataWarehouse;
-- Checks and drops tables if they exist
IF OBJECT_ID('Bronze.Bike_Sales_2021', 'U') IS NOT NULL
    DROP TABLE Bronze.Bike_Sales_2021;

IF OBJECT_ID('Bronze.Bike_Sales_2022', 'U') IS NOT NULL
    DROP TABLE Bronze.Bike_Sales_2022;


-- Create TABLE Bronze.Bike_Sales_2021 with precise data types
CREATE TABLE Bronze.Bike_Sales_2021 (
    [Date] VARCHAR(50) NOT NULL,
    [Day] INT NOT NULL,
    [Month] VARCHAR(50) NOT NULL,
    [Year] INT NOT NULL,
    Customer_Age INT NOT NULL,
    Age_Group VARCHAR(100),
    Customer_Gender CHAR(1),
    Country VARCHAR(100),
    [State] VARCHAR(100), 
    Product_Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    Product VARCHAR(500),
    Order_Quantity VARCHAR(20) NOT NULL,
    Unit_Cost VARCHAR(50) NOT NULL,
    Unit_Price VARCHAR(50) NOT NULL,
    Profit VARCHAR(50) NOT NULL,
    Cost VARCHAR(50) NOT NULL,
    Revenue VARCHAR(100) NOT NULL
);

CREATE TABLE Bronze.Bike_Sales_2022 (
    [Date] VARCHAR(50) NOT NULL,
    [Day] INT NOT NULL,
    [Month] VARCHAR(50) NOT NULL,
    [Year] INT NOT NULL,
    Customer_Age INT NOT NULL,
    Age_Group VARCHAR(100),
    Customer_Gender CHAR(1),
    Country VARCHAR(100),
    [State] VARCHAR(100), 
    Product_Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    Product VARCHAR(500),
    Order_Quantity VARCHAR(20) NOT NULL,
    Unit_Cost VARCHAR(50) NOT NULL,
    Unit_Price VARCHAR(50) NOT NULL,
    Profit VARCHAR(50) NOT NULL,
    Cost VARCHAR(50) NOT NULL,
    Revenue VARCHAR(100) NOT NULL
);
GO
CREATE OR ALTER PROCEDURE Bronze.load_bronze
AS
BEGIN
    
    PRINT '>> Loading data into Bronze.Bike_Sales_2021 >>';
    TRUNCATE TABLE Bronze.Bike_Sales_2021;

    BULK INSERT Bronze.Bike_Sales_2021
    FROM 'C:\Data\Bike_Sales_2021_cleaned.csv'
    WITH (
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        --DATAFILETYPE='char',
        TABLOCK
    );

    PRINT '>> Loading data into Bronze.Bike_Sales_2022 >>';
    TRUNCATE TABLE Bronze.Bike_Sales_2022;

    BULK INSERT Bronze.Bike_Sales_2022
    FROM 'C:\Data\Bike_Sales_2022_cleaned.csv'
    WITH (
        FIRSTROW=2,
        FIELDTERMINATOR=',',
        --DATAFILETYPE='char',
        TABLOCK
    );
END;
GO
