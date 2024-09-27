{{ config(materialized='table') }}

WITH hourly_max_loss AS (
    SELECT
        trade_hour,
        MAX(max_close - min_open) AS max_loss
    FROM (
        SELECT
            DATE(open_time) AS trade_date,
            EXTRACT(HOUR FROM open_time) AS trade_hour,
            MAX(close) AS max_close,
            MIN(open) AS min_open
        FROM
            bitcoin_data
        GROUP BY
            trade_date, trade_hour
    ) AS hourly_max_loss_data
    GROUP BY
        trade_hour
)

SELECT
    trade_hour,
    max_loss
FROM
    hourly_max_loss
ORDER BY
    max_loss ASC
LIMIT 1


