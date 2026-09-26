USE retailiq;

CREATE OR REPLACE VIEW vw_clean_sales AS
SELECT
    s.sales_id,
    s.date,

    -- Store information
    s.store_id,
    st.region,

    -- Product information
    s.product_id,
    p.category,

    -- Calendar information
    c.year,
    c.month,
    c.quarter,
    c.day,
    c.day_of_week,
    c.is_weekend,

    -- Sales information
    s.weather_condition,
    s.units_sold,
    s.units_ordered,
    s.price,
    s.discount,
    s.promotion,
    s.competitor_pricing,
    s.seasonality,
    s.epidemic,
    s.demand,

    -- Inventory information
    i.inventory_level,

    -- Business features
    CASE
        WHEN i.inventory_level = 0 THEN 1
        ELSE 0
    END AS stockout_flag,

    ROUND(
        s.price - s.competitor_pricing,
        2
    ) AS price_difference,

    CASE
        WHEN s.competitor_pricing > 0
        THEN ROUND(
            s.price / s.competitor_pricing,
            4
        )
        ELSE NULL
    END AS price_ratio,

    CASE
        WHEN s.units_sold > 0
        THEN ROUND(
            i.inventory_level / s.units_sold,
            2
        )
        ELSE NULL
    END AS inventory_to_sales_ratio

FROM sales s

INNER JOIN products p
    ON s.product_id = p.product_id

INNER JOIN stores st
    ON s.store_id = st.store_id

INNER JOIN calendar c
    ON s.date = c.date

INNER JOIN inventory i
    ON s.date = i.date
    AND s.store_id = i.store_id
    AND s.product_id = i.product_id;