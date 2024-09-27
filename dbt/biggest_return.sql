{{ config(materialized='table') }}

WITH hourly_returns AS (
    SELECT
        trade_hour,
        SUM((sell_price - buy_price) / buy_price) AS total_return
    FROM (
        SELECT
            DATE(open_time) AS trade_date,
            EXTRACT(HOUR FROM open_time) AS trade_hour,
            FIRST_VALUE(open) OVER (PARTITION BY DATE(open_time), EXTRACT(HOUR FROM open_time) ORDER BY open_time) AS buy_price,
            LAST_VALUE(close) OVER (PARTITION BY DATE(open_time), EXTRACT(HOUR FROM open_time) ORDER BY open_time RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS sell_price
        FROM
            bitcoin_data
    ) AS hourly_returns_data
    GROUP BY
        trade_hour
)

SELECT
    trade_hour,
    total_return
FROM
    hourly_returns
ORDER BY
    total_return DESC
LIMIT 1;

