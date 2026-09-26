USE retailiq;

-- 1. Table row counts
SELECT 'products' AS table_name, COUNT(*) AS row_count
FROM products

UNION ALL

SELECT 'stores', COUNT(*)
FROM stores

UNION ALL

SELECT 'calendar', COUNT(*)
FROM calendar

UNION ALL

SELECT 'sales', COUNT(*)
FROM sales

UNION ALL

SELECT 'inventory', COUNT(*)
FROM inventory

UNION ALL

SELECT 'promotions', COUNT(*)
FROM promotions;


-- 2. Check sales date range
SELECT
    MIN(date) AS first_date,
    MAX(date) AS last_date
FROM sales;


-- 3. Check inventory date range
SELECT
    MIN(date) AS first_date,
    MAX(date) AS last_date
FROM inventory;


-- 4. Check for orphan sales records
SELECT COUNT(*) AS orphan_sales
FROM sales s
LEFT JOIN products p
    ON s.product_id = p.product_id
LEFT JOIN stores st
    ON s.store_id = st.store_id
LEFT JOIN calendar c
    ON s.date = c.date
WHERE p.product_id IS NULL
   OR st.store_id IS NULL
   OR c.date IS NULL;


-- 5. Check for orphan inventory records
SELECT COUNT(*) AS orphan_inventory
FROM inventory i
LEFT JOIN products p
    ON i.product_id = p.product_id
LEFT JOIN stores st
    ON i.store_id = st.store_id
LEFT JOIN calendar c
    ON i.date = c.date
WHERE p.product_id IS NULL
   OR st.store_id IS NULL
   OR c.date IS NULL;