DROP TABLE if EXISTS stg.stg_order_items;

CREATE TABLE stg.stg_order_items 
as SELECT
    order_id::TEXT as order_id,
    order_item_id::int as order_item_id,
    product_id::text as product_id,
    seller_id::text as seller_id,
    shipping_limit_date::TIMESTAMPtz as shipping_limit_ts,
    price::numeric(12,2) as price,
    freight_value::numeric(12,2) as freight_value
FROM public.raw_order_items;


select * from stg.stg_order_items limit 20



