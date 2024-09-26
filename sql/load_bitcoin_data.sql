COPY public.bitcoin_data(open_time, open, high, low, close, volume, close_time, quote_asset_volume, number_of_trades, taker_buy_base_asset_volume, taker_buy_quote_asset_volume, ignore)
FROM '/usr/src/app/half2_BTCUSDT_1s.csv'
WITH (FORMAT CSV, HEADER);