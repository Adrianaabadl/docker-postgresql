{{ config(materialized='table') }}


WITH returns AS (
    SELECT 
        EXTRACT(HOUR FROM open_time) AS hour,
        (MAX(close) - MIN(open)) AS profit_loss
    FROM 
        public.bitcoin_data
    WHERE 
        open_time >= '2023-01-01 00:00:00' AND open_time < '2023-12-31 23:59:59'
    GROUP BY 
        hour
)

SELECT 
    hour, 
    profit_loss,
    RANK() OVER (ORDER BY profit_loss DESC) AS rank
FROM 
    returns
ORDER BY 
    profit_loss DESC
LIMIT 1



