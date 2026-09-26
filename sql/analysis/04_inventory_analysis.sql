USE retailiq;


-- 1. Overall inventory health

SELECT
    COUNT(*) AS total_inventory_records,

    SUM(
        CASE
            WHEN inventory_level = 0 THEN 1
            ELSE 0
        END
    ) AS zero_inventory_records,

    ROUND(AVG(inventory_level), 2) AS average_inventory,

    MIN(inventory_level) AS minimum_inventory,
    MAX(inventory_level) AS maximum_inventory

FROM inventory;


-- 2. Inventory status distribution

SELECT
    inventory_status,
    COUNT(*) AS record_count
FROM vw_inventory_features
GROUP BY inventory_status
ORDER BY record_count DESC;


-- 3. Inventory below demand

SELECT
    COUNT(*) AS records_below_demand,

    ROUND(
        100 * COUNT(*) /
        (SELECT COUNT(*) FROM inventory),
        2
    ) AS percentage_of_records

FROM vw_inventory_features
WHERE inventory_below_demand = 1;


-- 4. Products with highest stockout frequency

SELECT
    product_id,
    category,
    SUM(stockout_flag) AS stockout_days,
    COUNT(*) AS total_records,

    ROUND(
        100 * SUM(stockout_flag) / COUNT(*),
        2
    ) AS stockout_rate

FROM vw_inventory_features

GROUP BY
    product_id,
    category

ORDER BY stockout_rate DESC
LIMIT 10;


-- 5. Store inventory health

SELECT
    store_id,
    region,

    ROUND(AVG(inventory_level), 2) AS average_inventory,

    SUM(stockout_flag) AS stockout_days,

    ROUND(
        100 * SUM(stockout_flag) / COUNT(*),
        2
    ) AS stockout_rate

FROM vw_inventory_features

GROUP BY
    store_id,
    region

ORDER BY stockout_rate DESC;


-- 6. High inventory / possible overstock

SELECT
    product_id,
    category,

    ROUND(AVG(inventory_level), 2) AS average_inventory,
    ROUND(AVG(demand), 2) AS average_demand,

    ROUND(
        AVG(inventory_level) / NULLIF(AVG(demand), 0),
        2
    ) AS inventory_to_demand_ratio

FROM vw_inventory_features

GROUP BY
    product_id,
    category

HAVING inventory_to_demand_ratio > 3

ORDER BY inventory_to_demand_ratio DESC;