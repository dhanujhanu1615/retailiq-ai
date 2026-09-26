USE retailiq;

CREATE OR REPLACE VIEW vw_inventory_features AS
SELECT
    i.inventory_id,
    i.date,
    i.store_id,
    st.region,
    i.product_id,
    p.category,

    -- Inventory
    i.inventory_level,

    -- Sales
    s.units_sold,
    s.units_ordered,
    s.demand,

    -- Pricing
    s.price,
    s.competitor_pricing,
    s.discount,
    s.promotion,

    -- Inventory indicators
    CASE
        WHEN i.inventory_level = 0 THEN 1
        ELSE 0
    END AS stockout_flag,

    CASE
        WHEN i.inventory_level < s.demand THEN 1
        ELSE 0
    END AS inventory_below_demand,

    CASE
        WHEN s.units_sold > 0
        THEN ROUND(i.inventory_level / s.units_sold, 2)
        ELSE NULL
    END AS inventory_to_sales_ratio,

    CASE
        WHEN i.inventory_level < s.demand * 0.5 THEN 'Critical'
        WHEN i.inventory_level < s.demand THEN 'Low'
        WHEN i.inventory_level < s.demand * 2 THEN 'Adequate'
        ELSE 'High'
    END AS inventory_status

FROM inventory i

INNER JOIN sales s
    ON i.date = s.date
    AND i.store_id = s.store_id
    AND i.product_id = s.product_id

INNER JOIN products p
    ON i.product_id = p.product_id

INNER JOIN stores st
    ON i.store_id = st.store_id;