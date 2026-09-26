USE retailiq;


-- 1. Overall stockout performance

SELECT
    COUNT(*) AS total_records,

    SUM(
        CASE
            WHEN inventory_level = 0 THEN 1
            ELSE 0
        END
    ) AS stockout_records,

    ROUND(
        100 * SUM(
            CASE
                WHEN inventory_level = 0 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS stockout_rate

FROM inventory;


-- 2. Stockouts by category

SELECT
    category,

    COUNT(*) AS total_records,

    SUM(stockout_flag) AS stockout_records,

    ROUND(
        100 * SUM(stockout_flag) / COUNT(*),
        2
    ) AS stockout_rate

FROM vw_inventory_features

GROUP BY category

ORDER BY stockout_rate DESC;


-- 3. Stockouts by region

SELECT
    region,

    COUNT(*) AS total_records,

    SUM(stockout_flag) AS stockout_records,

    ROUND(
        100 * SUM(stockout_flag) / COUNT(*),
        2
    ) AS stockout_rate

FROM vw_inventory_features

GROUP BY region

ORDER BY stockout_rate DESC;


-- 4. Stockouts during promotions

SELECT
    CASE
        WHEN promotion = 1 THEN 'Promotion'
        ELSE 'No Promotion'
    END AS promotion_status,

    COUNT(*) AS total_records,

    SUM(stockout_flag) AS stockout_records,

    ROUND(
        100 * SUM(stockout_flag) / COUNT(*),
        2
    ) AS stockout_rate

FROM vw_inventory_features

GROUP BY promotion

ORDER BY stockout_rate DESC;


-- 5. Stockouts by weather condition

SELECT
    weather_condition,

    COUNT(*) AS total_records,

    SUM(stockout_flag) AS stockout_records,

    ROUND(
        100 * SUM(stockout_flag) / COUNT(*),
        2
    ) AS stockout_rate

FROM vw_inventory_features

GROUP BY weather_condition

ORDER BY stockout_rate DESC;


-- 6. Products with both high demand and stockouts

SELECT
    product_id,
    category,

    ROUND(AVG(demand), 2) AS average_demand,

    SUM(stockout_flag) AS stockout_days,

    ROUND(
        100 * SUM(stockout_flag) / COUNT(*),
        2
    ) AS stockout_rate

FROM vw_inventory_features

GROUP BY
    product_id,
    category

HAVING
    AVG(demand) > (
        SELECT AVG(demand)
        FROM vw_inventory_features
    )
    AND SUM(stockout_flag) > 0

ORDER BY
    stockout_rate DESC;