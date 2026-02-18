COPY raw_customers FROM '/data/olist_customers_dataset.csv' WITH (FORMAT csv, HEADER true);

COPY raw_orders FROM '/data/olist_orders_dataset.csv' WITH (FORMAT csv, HEADER true);

COPY raw_order_items FROM '/data/olist_order_items_dataset.csv' WITH (FORMAT csv, HEADER true);

-- table created, '' shows csv file inside, format indicates csv file, header means first row is columns

SELECT 'raw_customers' AS table, 
COUNT(*) FROM raw_customers

UNION ALL SELECT 'raw_orders',
COUNT(*) FROM raw_orders

UNION ALL SELECT 'raw_order_items',
COUNT(*) FROM raw_order_items;

