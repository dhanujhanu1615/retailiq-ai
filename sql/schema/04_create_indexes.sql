-- ============================================================
-- RetailIQ
-- SQL Phase — Step 4
-- Create Database Indexes
-- ============================================================

USE retailiq;


-- ============================================================
-- SALES INDEXES
-- ============================================================

CREATE INDEX idx_sales_date
ON sales(date);

CREATE INDEX idx_sales_store
ON sales(store_id);

CREATE INDEX idx_sales_product
ON sales(product_id);

CREATE INDEX idx_sales_store_product_date
ON sales(store_id, product_id, date);


-- ============================================================
-- INVENTORY INDEXES
-- ============================================================

CREATE INDEX idx_inventory_date
ON inventory(date);

CREATE INDEX idx_inventory_store
ON inventory(store_id);

CREATE INDEX idx_inventory_product
ON inventory(product_id);

CREATE INDEX idx_inventory_store_product_date
ON inventory(store_id, product_id, date);


-- ============================================================
-- PROMOTION INDEXES
-- ============================================================

CREATE INDEX idx_promotions_date
ON promotions(date);

CREATE INDEX idx_promotions_store
ON promotions(store_id);

CREATE INDEX idx_promotions_product
ON promotions(product_id);

CREATE INDEX idx_promotions_store_product_date
ON promotions(store_id, product_id, date);


-- ============================================================
-- VERIFY INDEXES
-- ============================================================

SHOW INDEX FROM sales;

SHOW INDEX FROM inventory;

SHOW INDEX FROM promotions;