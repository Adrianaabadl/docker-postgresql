CREATE EXTENSION IF NOT EXISTS dblink;

DO $$ 
BEGIN
    -- Verificar si la base de datos ya existe
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'bitcoin_engine') THEN
        PERFORM dblink_exec('dbname=postgres', 'CREATE DATABASE bitcoin_engine');
    END IF;
END $$;

\connect bitcoin_engine;

CREATE TABLE IF NOT EXISTS public.bitcoin_data (
    open_time TIMESTAMP NOT NULL,
    open FLOAT NOT NULL,
    high FLOAT NOT NULL,
    low FLOAT NOT NULL,
    close FLOAT NOT NULL,
    volume FLOAT NOT NULL,
    close_time TIMESTAMP NOT NULL,
    quote_asset_volume FLOAT NOT NULL,
    number_of_trades INT NOT NULL,
    taker_buy_base_asset_volume FLOAT NOT NULL,
    taker_buy_quote_asset_volume FLOAT NOT NULL,
    ignore TEXT DEFAULT NULL
);

DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE tablename='bitcoin_data' AND indexname='idx_open_time') THEN
        CREATE INDEX idx_open_time ON public.bitcoin_data(open_time);
    END IF;
END $$;
