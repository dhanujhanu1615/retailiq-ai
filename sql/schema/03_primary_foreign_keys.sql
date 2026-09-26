-- ============================================================
-- RetailIQ
-- SQL Phase — Step 3
-- Primary Keys & Foreign Keys
-- ============================================================

USE retailiq;


-- ============================================================
-- SALES FOREIGN KEYS
-- ============================================================

ALTER TABLE sales
ADD CONSTRAINT fk_sales_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE sales
ADD CONSTRAINT fk_sales_store
FOREIGN KEY (store_id)
REFERENCES stores(store_id);

ALTER TABLE sales
ADD CONSTRAINT fk_sales_date
FOREIGN KEY (date)
REFERENCES calendar(date);


-- ============================================================
-- INVENTORY FOREIGN KEYS
-- ============================================================

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_store
FOREIGN KEY (store_id)
REFERENCES stores(store_id);

ALTER TABLE inventory
ADD CONSTRAINT fk_inventory_date
FOREIGN KEY (date)
REFERENCES calendar(date);


-- ============================================================
-- PROMOTIONS FOREIGN KEYS
-- ============================================================

ALTER TABLE promotions
ADD CONSTRAINT fk_promotions_product
FOREIGN KEY (product_id)
REFERENCES products(product_id);

ALTER TABLE promotions
ADD CONSTRAINT fk_promotions_store
FOREIGN KEY (store_id)
REFERENCES stores(store_id);

ALTER TABLE promotions
ADD CONSTRAINT fk_promotions_date
FOREIGN KEY (date)
REFERENCES calendar(date);


-- ============================================================
-- VERIFY FOREIGN KEYS
-- ============================================================

SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE CONSTRAINT_SCHEMA = 'retailiq'
  AND REFERENCED_TABLE_NAME IS NOT NULL;