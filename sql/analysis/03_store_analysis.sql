USE retailiq;


-- 1. Store performance

SELECT
    store_id,
    region,
    total_units_sold,
    total_demand,
    total_units_ordered,
    ROUND(average_price, 2) AS average_price,
    ROUND(average_inventory, 2) AS average_inventory,
    stockout_days
FROM vw_store_performance
ORDER BY total_demand DESC;


-- 2. Region performance

SELECT
    st.region,
    COUNT(DISTINCT s.store_id) AS store_count,
    SUM(s.units_sold) AS total_units_sold,
    SUM(s.demand) AS total_demand,
    SUM(s.units_ordered) AS total_units_ordered,
    ROUND(AVG(i.inventory_level), 2) AS average_inventory
FROM sales s
INNER JOIN stores st
    ON s.store_id = st.store_id
INNER JOIN inventory i
    ON s.date = i.date
    AND s.store_id = i.store_id
    AND s.product_id = i.product_id
GROUP BY st.region
ORDER BY total_demand DESC;


-- 3. Stores with the most stockout days

SELECT
    store_id,
    region,
    stockout_days,
    total_demand
FROM vw_store_performance
ORDER BY stockout_days DESC;


-- 4. High-demand stores with relatively low inventory

SELECT
    store_id,
    region,
    total_demand,
    ROUND(average_inventory, 2) AS average_inventory,
    stockout_days
FROM vw_store_performance
WHERE total_demand > (
    SELECT AVG(total_demand)
    FROM vw_store_performance
)
ORDER BY average_inventory ASC;