

EXEC Bronze.load_bronze;

IF OBJECT_ID('Silver.Bike_Sales_2021', 'U') IS NOT NULL
    DROP TABLE Silver.Bike_Sales_2021;
GO


CREATE TABLE Silver.Bike_Sales_2021 (
    [Date] DATE NOT NULL, 
    [Day] INT NOT NULL,
    [Month] VARCHAR(50) NOT NULL,
    [Year] INT NOT NULL,
    Customer_Age INT NOT NULL,
    Age_Group VARCHAR(100),
    Customer_Gender VARCHAR(10), 
    Country VARCHAR(100),
    [State] VARCHAR(100), 
    Product_Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    Product VARCHAR(500),
    Order_Quantity INT NOT NULL, 
    Unit_Cost DECIMAL(10, 2) NOT NULL, 
    Unit_Price DECIMAL(10, 2) NOT NULL, 
    Profit DECIMAL(10, 2) NOT NULL, 
    Cost DECIMAL(10, 2) NOT NULL,
    Revenue DECIMAL(10, 2) NOT NULL 
); 
GO


INSERT INTO Silver.Bike_Sales_2021 (
    [Date], Day, Month, Year, Customer_Age, Age_Group, Customer_Gender, 
    Country, [State], Product_Category, Sub_Category, Product, 
    Order_Quantity, Unit_Cost, Unit_Price, Profit, Cost, Revenue
)
SELECT
    -- Date Transformation (outputs DATE type, matching the target column)
    TRY_CONVERT(DATE, REPLACE(d.Date, '/', '-'), 105) AS Date, 
    d.Day,
    d.Month,
    d.Year,
    d.Customer_Age,
    d.Age_Group,
    CASE 
        WHEN UPPER(TRIM(d.Customer_Gender)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(d.Customer_Gender)) = 'M' THEN 'Male'
        ELSE 'Unknown' -- Best practice for completeness
    END AS Customer_Gender, 
    TRIM(d.Country),
    TRIM(d.State),
    TRIM(d.Product_Category),
    TRIM(d.Sub_Category),
    TRIM(d.Product),
    
    TRY_CAST(TRIM(d.Order_Quantity) AS INT) AS Order_Quantity, 
    
    TRY_CAST(TRIM(d.Unit_Cost) AS DECIMAL(10, 2)) AS Unit_Cost, 
    TRY_CAST(TRIM(d.Unit_Price) AS DECIMAL(10, 2)) AS Unit_Price,
    TRY_CAST(TRIM(d.Profit) AS DECIMAL(10, 2)) AS Profit,
    TRY_CAST(TRIM(d.Cost) AS DECIMAL(10, 2)) AS Cost,
    TRY_CAST(TRIM(d.Revenue) AS DECIMAL(10, 2)) AS Revenue
FROM
    Bronze.Bike_Sales_2021 d;
SELECT * FROM Silver.Bike_Sales_2021;

-- Corrected Drop Check for Silver Table 2022 (Assuming the Bronze table still exists)
IF OBJECT_ID('Silver.Bike_Sales_2022', 'U') IS NOT NULL
    DROP TABLE Silver.Bike_Sales_2022;
GO
CREATE TABLE Silver.Bike_Sales_2022 (
    [Date] DATE NOT NULL, 
    [Day] INT NOT NULL,
    [Month] VARCHAR(50) NOT NULL,
    [Year] INT NOT NULL,
    Customer_Age INT NOT NULL,
    Age_Group VARCHAR(100),
    Customer_Gender VARCHAR(10), 
    Country VARCHAR(100),
    [State] VARCHAR(100), 
    Product_Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    Product VARCHAR(500),
    Order_Quantity INT NOT NULL, 
    Unit_Cost DECIMAL(10, 2) NOT NULL, 
    Unit_Price DECIMAL(10, 2) NOT NULL, 
    Profit DECIMAL(10, 2) NOT NULL, 
    Cost DECIMAL(10, 2) NOT NULL,
    Revenue DECIMAL(10, 2) NOT NULL 
); 
GO


INSERT INTO Silver.Bike_Sales_2022 (
    [Date], Day, Month, Year, Customer_Age, Age_Group, Customer_Gender, 
    Country, [State], Product_Category, Sub_Category, Product, 
    Order_Quantity, Unit_Cost, Unit_Price, Profit, Cost, Revenue
)
SELECT
    -- Date Transformation (outputs DATE type, matching the target column)
    TRY_CONVERT(DATE, REPLACE(c.Date, '/', '-'), 105) AS Date, 
    c.Day,
    c.Month,
    c.Year,
    c.Customer_Age,
    c.Age_Group,
    CASE 
        WHEN UPPER(TRIM(c.Customer_Gender)) = 'F' THEN 'Female'
        WHEN UPPER(TRIM(c.Customer_Gender)) = 'M' THEN 'Male'
        ELSE 'Unknown' -- Best practice for completeness
    END AS Customer_Gender, 
    TRIM(c.Country),
    TRIM(c.State),
    TRIM(c.Product_Category),
    TRIM(c.Sub_Category),
    TRIM(c.Product),
    
    TRY_CAST(TRIM(c.Order_Quantity) AS INT) AS Order_Quantity, 
    
    TRY_CAST(TRIM(c.Unit_Cost) AS DECIMAL(10, 2)) AS Unit_Cost, 
    TRY_CAST(TRIM(c.Unit_Price) AS DECIMAL(10, 2)) AS Unit_Price,
    TRY_CAST(TRIM(c.Profit) AS DECIMAL(10, 2)) AS Profit,
    TRY_CAST(TRIM(c.Cost) AS DECIMAL(10, 2)) AS Cost,
    TRY_CAST(TRIM(c.Revenue) AS DECIMAL(10, 2)) AS Revenue
FROM
    Bronze.Bike_Sales_2022 c;

SELECT * FROM Silver.Bike_Sales_2022;

-- Loading the data in the gold layer

IF OBJECT_ID('Gold.Combined_bike_sales_data', 'U') IS NOT NULL
    DROP TABLE Gold.Combined_bike_sales_data;
GO


CREATE TABLE Gold.Combined_bike_sales_data (
    [Date] DATE NOT NULL, 
    [Day] INT NOT NULL,
    [Month] VARCHAR(50) NOT NULL,
    [Year] INT NOT NULL,
    Customer_Age INT NOT NULL,
    Age_Group VARCHAR(100),
    Customer_Gender VARCHAR(10), 
    Country VARCHAR(100),
    [State] VARCHAR(100), 
    Product_Category VARCHAR(100),
    Sub_Category VARCHAR(100),
    Product VARCHAR(500),
    Order_Quantity INT NOT NULL, 
    Unit_Cost DECIMAL(10, 2) NOT NULL, 
    Unit_Price DECIMAL(10, 2) NOT NULL, 
    Profit DECIMAL(10, 2) NOT NULL, 
    Cost DECIMAL(10, 2) NOT NULL,
    Revenue DECIMAL(10, 2) NOT NULL 
); 
GO


INSERT INTO Gold.Combined_bike_sales_data (
    [Date], Day, Month, Year, Customer_Age, Age_Group, Customer_Gender, 
    Country, [State], Product_Category, Sub_Category, Product, 
    Order_Quantity, Unit_Cost, Unit_Price, Profit, Cost, Revenue
)

SELECT 
    [Date], Day, Month, Year, Customer_Age, Age_Group, Customer_Gender, 
    Country, [State], Product_Category, Sub_Category, Product, 
    Order_Quantity, Unit_Cost, Unit_Price, Profit, Cost, Revenue
FROM
    Silver.Bike_Sales_2021 

UNION ALL 

SELECT 
    [Date], Day, Month, Year, Customer_Age, Age_Group, Customer_Gender, 
    Country, [State], Product_Category, Sub_Category, Product, 
    Order_Quantity, Unit_Cost, Unit_Price, Profit, Cost, Revenue
FROM
    Silver.Bike_Sales_2022;


SELECT * FROM  Gold.Combined_bike_sales_data;
