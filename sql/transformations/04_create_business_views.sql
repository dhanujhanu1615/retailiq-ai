USE retailiq;


-- =========================================================
-- 1. Daily Sales Summary
-- =========================================================

CREATE OR REPLACE VIEW vw_daily_sales AS
SELECT
    date,
    SUM(units_sold) AS total_units_sold,
    SUM(units_ordered) AS total_units_ordered,
    SUM(demand) AS total_demand,
    AVG(price) AS average_price,
    AVG(discount) AS average_discount,
    SUM(CASE WHEN promotion = 1 THEN 1 ELSE 0 END) AS promotion_records
FROM sales
GROUP BY date;


-- =========================================================
-- 2. Product Performance Summary
-- =========================================================

CREATE OR REPLACE VIEW vw_product_performance AS
SELECT
    s.product_id,
    p.category,

    SUM(s.units_sold) AS total_units_sold,
    SUM(s.demand) AS total_demand,
    SUM(s.units_ordered) AS total_units_ordered,

    AVG(s.price) AS average_price,
    AVG(s.discount) AS average_discount,

    AVG(i.inventory_level) AS average_inventory,

    SUM(
        CASE
            WHEN i.inventory_level = 0 THEN 1
            ELSE 0
        END
    ) AS stockout_days

FROM sales s

INNER JOIN products p
    ON s.product_id = p.product_id

INNER JOIN inventory i
    ON s.date = i.date
    AND s.store_id = i.store_id
    AND s.product_id = i.product_id

GROUP BY
    s.product_id,
    p.category;


-- =========================================================
-- 3. Store Performance Summary
-- =========================================================

CREATE OR REPLACE VIEW vw_store_performance AS
SELECT
    s.store_id,
    st.region,

    SUM(s.units_sold) AS total_units_sold,
    SUM(s.demand) AS total_demand,
    SUM(s.units_ordered) AS total_units_ordered,

    AVG(s.price) AS average_price,
    AVG(i.inventory_level) AS average_inventory,

    SUM(
        CASE
            WHEN i.inventory_level = 0 THEN 1
            ELSE 0
        END
    ) AS stockout_days

FROM sales s

INNER JOIN stores st
    ON s.store_id = st.store_id

INNER JOIN inventory i
    ON s.date = i.date
    AND s.store_id = i.store_id
    AND s.product_id = i.product_id

GROUP BY
    s.store_id,
    st.region;