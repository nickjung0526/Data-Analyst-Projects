BEGIN;

DROP TABLE IF EXISTS raw_customers;
CREATE TABLE raw_customers (
    customer_id TEXT,
    customer_unique_id TEXT ,
    customer_zip_code_prefix TEXT,
    customer_city TEXT,
    customer_state TEXT
);


DROP TABLE IF EXISTS raw_orders;
CREATE TABLE raw_orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TEXT,
    order_approved_at TEXT,
    order_delivered_carrier_date TEXT,
    order_delivered_customer_date TEXT,
    order_estimated_delivery_date TEXT
);


DROP TABLE IF EXISTS raw_order_items;
CREATE TABLE raw_order_items (
    order_id TEXT,
    order_item_id TEXT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TEXT,
    price TEXT,
    freight_value TEXT
);

-- build the others later, which include raw_products, raw_sellers, raw_order_reviews, raw_geolocation, raw_category_translation

COMMIT;

