USE retailiq;


-- =========================================================
-- 1. Rank products by total demand
-- =========================================================

WITH product_demand AS (
    SELECT
        product_id,
        category,
        SUM(demand) AS total_demand
    FROM sales
    GROUP BY
        product_id,
        category
)

SELECT
    product_id,
    category,
    total_demand,

    RANK() OVER (
        ORDER BY total_demand DESC
    ) AS demand_rank

FROM product_demand

ORDER BY demand_rank;


-- =========================================================
-- 2. Rank products within each category
-- =========================================================

WITH product_demand AS (
    SELECT
        product_id,
        category,
        SUM(demand) AS total_demand
    FROM sales
    GROUP BY
        product_id,
        category
)

SELECT
    product_id,
    category,
    total_demand,

    RANK() OVER (
        PARTITION BY category
        ORDER BY total_demand DESC
    ) AS category_demand_rank

FROM product_demand

ORDER BY
    category,
    category_demand_rank;


-- =========================================================
-- 3. Monthly demand with previous-month comparison
-- =========================================================

WITH monthly_demand AS (
    SELECT
        YEAR(date) AS year,
        MONTH(date) AS month,
        SUM(demand) AS total_demand
    FROM sales
    GROUP BY
        YEAR(date),
        MONTH(date)
)

SELECT
    year,
    month,
    total_demand,

    LAG(total_demand) OVER (
        ORDER BY year, month
    ) AS previous_month_demand,

    total_demand
    -
    LAG(total_demand) OVER (
        ORDER BY year, month
    ) AS demand_change

FROM monthly_demand

ORDER BY
    year,
    month;


-- =========================================================
-- 4. Store demand ranking within each region
-- =========================================================

WITH store_demand AS (
    SELECT
        s.store_id,
        st.region,
        SUM(s.demand) AS total_demand
    FROM sales s
    INNER JOIN stores st
        ON s.store_id = st.store_id
    GROUP BY
        s.store_id,
        st.region
)

SELECT
    store_id,
    region,
    total_demand,

    RANK() OVER (
        PARTITION BY region
        ORDER BY total_demand DESC
    ) AS regional_rank

FROM store_demand

ORDER BY
    region,
    regional_rank;


-- =========================================================
-- 5. Products with above-average demand
-- =========================================================

WITH product_demand AS (
    SELECT
        product_id,
        category,
        SUM(demand) AS total_demand
    FROM sales
    GROUP BY
        product_id,
        category
),

average_demand AS (
    SELECT
        AVG(total_demand) AS avg_product_demand
    FROM product_demand
)

SELECT
    p.product_id,
    p.category,
    p.total_demand,
    ROUND(a.avg_product_demand, 2) AS average_product_demand

FROM product_demand p

CROSS JOIN average_demand a

WHERE p.total_demand > a.avg_product_demand

ORDER BY p.total_demand DESC;


-- =========================================================
-- 6. Stockout rate ranking by product
-- =========================================================

WITH product_stockouts AS (
    SELECT
        product_id,
        category,

        COUNT(*) AS total_records,

        SUM(stockout_flag) AS stockout_records

    FROM vw_inventory_features

    GROUP BY
        product_id,
        category
)

SELECT
    product_id,
    category,
    total_records,
    stockout_records,

    ROUND(
        100 * stockout_records / total_records,
        2
    ) AS stockout_rate,

    RANK() OVER (
        ORDER BY
            stockout_records / total_records DESC
    ) AS stockout_risk_rank

FROM product_stockouts

ORDER BY stockout_risk_rank;