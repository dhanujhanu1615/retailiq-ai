-- ============================================================
-- RetailIQ
-- SQL Phase — Step 2
-- Create Core Tables
-- ============================================================

USE retailiq;


-- ============================================================
-- 1. PRODUCTS
-- ============================================================

CREATE TABLE IF NOT EXISTS products (
    product_id VARCHAR(20) NOT NULL,
    category VARCHAR(50) NOT NULL,

    PRIMARY KEY (product_id)
);


-- ============================================================
-- 2. STORES
-- ============================================================

CREATE TABLE IF NOT EXISTS stores (
    store_id VARCHAR(20) NOT NULL,
    region VARCHAR(50) NOT NULL,

    PRIMARY KEY (store_id)
);


-- ============================================================
-- 3. CALENDAR
-- ============================================================

CREATE TABLE IF NOT EXISTS calendar (
    date DATE NOT NULL,
    year INT,
    month INT,
    quarter INT,
    day INT,
    day_of_week INT,
    is_weekend BOOLEAN,
    seasonality VARCHAR(20),

    PRIMARY KEY (date)
);


-- ============================================================
-- 4. SALES
-- ============================================================

CREATE TABLE IF NOT EXISTS sales (
    sales_id BIGINT AUTO_INCREMENT,

    date DATE NOT NULL,
    store_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,

    weather_condition VARCHAR(30),

    units_sold INT,
    units_ordered INT,

    price DECIMAL(10,2),
    discount DECIMAL(5,2),

    promotion BOOLEAN,

    competitor_pricing DECIMAL(10,2),

    seasonality VARCHAR(20),

    epidemic BOOLEAN,

    demand INT,

    PRIMARY KEY (sales_id)
);


-- ============================================================
-- 5. INVENTORY
-- ============================================================

CREATE TABLE IF NOT EXISTS inventory (
    inventory_id BIGINT AUTO_INCREMENT,

    date DATE NOT NULL,
    store_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,

    inventory_level INT,

    PRIMARY KEY (inventory_id)
);


-- ============================================================
-- 6. PROMOTIONS
-- ============================================================

CREATE TABLE IF NOT EXISTS promotions (
    promotion_id BIGINT AUTO_INCREMENT,

    date DATE NOT NULL,
    store_id VARCHAR(20) NOT NULL,
    product_id VARCHAR(20) NOT NULL,

    promotion BOOLEAN,
    discount DECIMAL(5,2),

    PRIMARY KEY (promotion_id)
);


-- ============================================================
-- VERIFY TABLES
-- ============================================================

SHOW TABLES;