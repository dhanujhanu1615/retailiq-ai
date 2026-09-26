USE retailiq;


-- 1. Overall demand statistics

SELECT
    SUM(demand) AS total_demand,
    ROUND(AVG(demand), 2) AS average_daily_record_demand,
    MIN(demand) AS minimum_demand,
    MAX(demand) AS maximum_demand
FROM sales;


-- 2. Monthly demand trend

SELECT
    YEAR(date) AS year,
    MONTH(date) AS month,

    SUM(demand) AS total_demand,

    ROUND(AVG(demand), 2) AS average_demand

FROM sales

GROUP BY
    YEAR(date),
    MONTH(date)

ORDER BY
    year,
    month;


-- 3. Demand by category

SELECT
    category,

    SUM(demand) AS total_demand,

    ROUND(AVG(demand), 2) AS average_demand,

    MAX(demand) AS maximum_demand

FROM vw_clean_sales

GROUP BY category

ORDER BY total_demand DESC;


-- 4. Demand by seasonality

SELECT
    seasonality,

    COUNT(*) AS total_records,

    SUM(demand) AS total_demand,

    ROUND(AVG(demand), 2) AS average_demand

FROM sales

GROUP BY seasonality

ORDER BY average_demand DESC;


-- 5. Demand during epidemic vs normal periods

SELECT
    CASE
        WHEN epidemic = 1 THEN 'Epidemic'
        ELSE 'Normal'
    END AS epidemic_status,

    COUNT(*) AS total_records,

    ROUND(AVG(demand), 2) AS average_demand,

    SUM(demand) AS total_demand

FROM sales

GROUP BY epidemic

ORDER BY average_demand DESC;


-- 6. Highest-demand product/store combinations

SELECT
    store_id,
    product_id,
    category,

    SUM(demand) AS total_demand,

    ROUND(AVG(demand), 2) AS average_demand

FROM vw_clean_sales

GROUP BY
    store_id,
    product_id,
    category

ORDER BY total_demand DESC

LIMIT 20;