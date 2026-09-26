USE retailiq;


-- 1. Product performance

SELECT
    product_id,
    category,
    total_units_sold,
    total_demand,
    total_units_ordered,
    ROUND(average_price, 2) AS average_price,
    ROUND(average_inventory, 2) AS average_inventory,
    stockout_days
FROM vw_product_performance
ORDER BY total_demand DESC;


-- 2. Category performance

SELECT
    p.category,

    SUM(s.units_sold) AS total_units_sold,
    SUM(s.demand) AS total_demand,
    SUM(s.units_ordered) AS total_units_ordered,

    ROUND(AVG(s.price), 2) AS average_price,
    ROUND(AVG(i.inventory_level), 2) AS average_inventory,

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

GROUP BY p.category
ORDER BY total_demand DESC;


-- 3. Products with the most stockout days

SELECT
    product_id,
    category,
    stockout_days,
    total_demand
FROM vw_product_performance
ORDER BY stockout_days DESC
LIMIT 10;


-- 4. Products with high demand but low average inventory

SELECT
    product_id,
    category,
    total_demand,
    ROUND(average_inventory, 2) AS average_inventory,
    stockout_days
FROM vw_product_performance
WHERE total_demand > (
    SELECT AVG(total_demand)
    FROM vw_product_performance
)
ORDER BY average_inventory ASC;