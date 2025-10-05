## Project Name
# ETL Pipeline with T-SQL and SQL Server (Bike Sales Analysis)

# Overview

This ETL demonstrates a robust **Medallion Architecture** $\text{ETL}$ pipeline implemented entirely with **$\text{T-SQL}$** within **SQL Server**. The pipeline is designed to efficiently process, clean, and load Bike Sales data from two source years ($\text{CSV}$ files) into a structured Data Warehouse, creating a clean, integrated **Gold Layer** ready for business intelligence and analytics.

***

## Features

* **Medallion Architecture:** Follows the Bronze $\rightarrow$ Silver $\rightarrow$ Gold data layering standard for high integrity and scalability.
* **High-Speed Ingestion:** Utilizes the efficient **$\text{BULK INSERT}$** command for rapid raw data loading.
* **Comprehensive Data Cleansing:** Standardizes data types, handles complex date conversions, and cleans categorical fields (e.g., standardizing gender codes).
* **Data Integration:** Consolidates data from multiple sources (2021 and 2022) into a single analytical table using **$\text{UNION ALL}$**.
* **$\text{SQL}$ Focus:** Logic is implemented primarily through stored procedures and native $\text{T-SQL}$ for maximum performance.

***

## Getting Started

### Prerequisites

* SQL Server (or compatible database)
* Python
* **SQL Server Management Studio (SSMS)** to execute the scripts.
* The raw data files (`Bike_Sales_2021_cleaned.csv` and `Bike_Sales_2022_cleaned.csv`) must be placed in the location specified in the `load_bronze` stored procedure (e.g., `C:\Data\`).

### Setup

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/taylorwanyama/ETL-Pipeline-with-Python-and-SQL.git](https://github.com/taylorwanyama/ETL-Pipeline-with-Python-and-SQL.git)
    ```
2.  **Execute the SQL Scripts Sequentially:** Run the following files in order within SSMS:

    | Order | Steps | Description |
    | :--- | :--- | :--- |
    | **1** | `01_db_and_schemas_setup` | Creation of  the `ETL_DataWarehouse` database and the Bronze, Silver, and Gold schemas. |
    | **2** | `02_bronze_layer_load` | Creation raw tables and the `load_bronze` procedure to import $\text{CSV}$ data. |
    | **3** | `03_silver_layer_transform` | Execution of $\text{ETL}$ process to clean, standardize, and load the 2021 and 2022 data into the Silver Layer tables. |
    | **4** | `04_gold_layer_integration` | Merging of the two clean Silver tables into the final, combined Gold table using $\text{UNION ALL}$. |

***

## How It Works: The ETL Data Flow

This entire process is managed through sequential $\text{T-SQL}$ execution across the three architecture layers:

### 1.**Bronze Layer (Staging)**
* **Action:** High-volume ingestion. Raw data is loaded into two staging tables.
* **Structure:** Tables use **$\text{VARCHAR}$** data types for fields like `Date` and `Revenue` to accept source data errors without breaking the load.

### 2. **Silver Layer (Cleaning)**
* **Action:** Transformation and Standardization. $\text{T-SQL}$ reads data from the Bronze tables and applies cleansing logic:
    * **Type Safety:** Uses `TRY_CAST` and `TRY_CONVERT` to safely cast strings to $\text{DECIMAL}$, $\text{INT}$, and $\text{DATE}$ types.
    * **Data Quality:** $\text{CASE}$ statements standardize categorical fields (e.g., converting 'F' to 'Female' and 'M' to 'Male').
* **Output:** Two separate, clean, and standardized tables (`Silver.Bike_Sales_2021` and `Silver.Bike_Sales_2022`).

### 3. **Gold Layer (Integration)**
* **Action:** Final integration and preparation for $\text{BI}$.
* **Method:** The clean 2021 and 2022 datasets from the Silver Layer are combined using **$\text{UNION ALL}$** into a single master table, `Gold.Combined_bike_sales_data`. This unified structure is optimized for analytics and reporting tools.

***

*Created by [taylorwanyama](https://github.com/taylorwanyama)*
