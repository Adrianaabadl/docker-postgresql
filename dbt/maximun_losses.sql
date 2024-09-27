{{ config(materialized='table') }}

WITH losses AS (
    SELECT 
        EXTRACT(HOUR FROM open_time) AS hour,
        (MIN(close) - MAX(open)) AS max_loss
    FROM 
        public.bitcoin_data
    WHERE 
        open_time >= '2023-01-01 00:00:00' AND open_time < '2023-12-31 23:59:59'
    GROUP BY 
        hour
)

SELECT 
    hour, 
    max_loss,
    RANK() OVER (ORDER BY max_loss ASC) AS rank
FROM 
    losses
ORDER BY 
    max_loss ASC
LIMIT 1
