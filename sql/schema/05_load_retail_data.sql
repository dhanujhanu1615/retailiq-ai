-- ============================================================
-- RetailIQ
-- SQL Phase — Step 5
-- Load RetailIQ Dataset
-- ============================================================

USE retailiq;


-- ============================================================
-- 1. CREATE STAGING TABLE
-- ============================================================

DROP TABLE IF EXISTS staging_sales_data;

CREATE TABLE staging_sales_data (
    date DATE,
    store_id VARCHAR(20),
    product_id VARCHAR(20),
    category VARCHAR(50),
    region VARCHAR(50),
    inventory_level INT,
    units_sold INT,
    units_ordered INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2),
    weather_condition VARCHAR(30),
    promotion BOOLEAN,
    competitor_pricing DECIMAL(10,2),
    seasonality VARCHAR(20),
    epidemic BOOLEAN,
    demand INT
);



SHOW TABLES LIKE 'staging_sales_data';

DESCRIBE staging_sales_data;



-- =======================================================================================
-- =======================================================================================
-- =======================================================================================
-- =======================================================================================

USE retailiq;

-- Step 5.1: Create staging table
DROP TABLE IF EXISTS staging_sales_data;

CREATE TABLE staging_sales_data (
    date DATE,
    store_id VARCHAR(20),
    product_id VARCHAR(20),
    category VARCHAR(50),
    region VARCHAR(50),
    inventory_level INT,
    units_sold INT,
    units_ordered INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2),
    weather_condition VARCHAR(30),
    promotion BOOLEAN,
    competitor_pricing DECIMAL(10,2),
    seasonality VARCHAR(20),
    epidemic BOOLEAN,
    demand INT
);

-- Step 5.2: Import CSV
LOAD DATA LOCAL INFILE
'C:/Users/dhanu/RetailIQ/data/raw/sales_data.csv'
INTO TABLE staging_sales_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    date,
    store_id,
    product_id,
    category,
    region,
    inventory_level,
    units_sold,
    units_ordered,
    price,
    discount,
    weather_condition,
    promotion,
    competitor_pricing,
    seasonality,
    epidemic,
    demand
);

-- Step 5.3: Verify row count
SELECT COUNT(*) AS total_rows
FROM staging_sales_data;

-- Step 5.4: Preview imported data
SELECT *
FROM staging_sales_data
LIMIT 5;