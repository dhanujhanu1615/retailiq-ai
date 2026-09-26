USE retailiq;


-- 1. Total business performance

SELECT
    SUM(units_sold) AS total_units_sold,
    SUM(units_ordered) AS total_units_ordered,
    SUM(demand) AS total_demand,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(discount), 2) AS average_discount
FROM sales;


-- 2. Monthly sales performance

SELECT
    YEAR(date) AS year,
    MONTH(date) AS month,
    SUM(units_sold) AS total_units_sold,
    SUM(demand) AS total_demand,
    SUM(units_ordered) AS total_units_ordered
FROM sales
GROUP BY
    YEAR(date),
    MONTH(date)
ORDER BY
    year,
    month;


-- 3. Sales by region

SELECT
    st.region,
    SUM(s.units_sold) AS total_units_sold,
    SUM(s.demand) AS total_demand,
    SUM(s.units_ordered) AS total_units_ordered
FROM sales s
INNER JOIN stores st
    ON s.store_id = st.store_id
GROUP BY st.region
ORDER BY total_demand DESC;


-- 4. Promotion vs non-promotion performance

SELECT
    CASE
        WHEN promotion = 1 THEN 'Promotion'
        ELSE 'No Promotion'
    END AS promotion_status,

    SUM(units_sold) AS total_units_sold,
    SUM(demand) AS total_demand,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(AVG(discount), 2) AS average_discount

FROM sales

GROUP BY promotion
ORDER BY total_demand DESC;