USE retailiq;

CREATE OR REPLACE VIEW vw_calendar AS
SELECT
    date,
    year,
    month,
    quarter,
    day,
    day_of_week,
    is_weekend,
    seasonality,

    CASE
        WHEN month IN (12, 1, 2) THEN 'Winter'
        WHEN month IN (3, 4, 5) THEN 'Spring'
        WHEN month IN (6, 7, 8) THEN 'Summer'
        WHEN month IN (9, 10, 11) THEN 'Autumn'
    END AS calendar_season,

    CASE
        WHEN day_of_week IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type

FROM calendar;