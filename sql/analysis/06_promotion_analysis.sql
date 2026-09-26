USE retailiq;


-- 1. Promotion vs non-promotion performance

SELECT
    CASE
        WHEN promotion = 1 THEN 'Promotion'
        ELSE 'No Promotion'
    END AS promotion_status,

    COUNT(*) AS total_records,

    SUM(units_sold) AS total_units_sold,

    SUM(demand) AS total_demand,

    ROUND(AVG(discount), 2) AS average_discount,

    ROUND(AVG(price), 2) AS average_price

FROM sales

GROUP BY promotion

ORDER BY total_demand DESC;


-- 2. Demand by discount level

SELECT
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount < 10 THEN 'Low Discount'
        WHEN discount < 25 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_level,

    COUNT(*) AS total_records,

    ROUND(AVG(demand), 2) AS average_demand,

    ROUND(AVG(units_sold), 2) AS average_units_sold

FROM sales

GROUP BY
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount < 10 THEN 'Low Discount'
        WHEN discount < 25 THEN 'Medium Discount'
        ELSE 'High Discount'
    END

ORDER BY average_demand DESC;


-- 3. Promotion and stockout relationship

SELECT
    CASE
        WHEN promotion = 1 THEN 'Promotion'
        ELSE 'No Promotion'
    END AS promotion_status,

    COUNT(*) AS total_records,

    SUM(v.stockout_flag) AS stockout_records,

    ROUND(
        100 * SUM(v.stockout_flag) / COUNT(*),
        2
    ) AS stockout_rate

FROM vw_inventory_features v

GROUP BY promotion

ORDER BY stockout_rate DESC;


-- 4. Category promotion performance

SELECT
    category,

    SUM(
        CASE
            WHEN promotion = 1 THEN 1
            ELSE 0
        END
    ) AS promotion_records,

    SUM(
        CASE
            WHEN promotion = 0 THEN 1
            ELSE 0
        END
    ) AS non_promotion_records,

    ROUND(
        AVG(
            CASE
                WHEN promotion = 1 THEN demand
            END
        ),
        2
    ) AS promotion_average_demand,

    ROUND(
        AVG(
            CASE
                WHEN promotion = 0 THEN demand
            END
        ),
        2
    ) AS non_promotion_average_demand

FROM vw_inventory_features

GROUP BY category

ORDER BY promotion_average_demand DESC;