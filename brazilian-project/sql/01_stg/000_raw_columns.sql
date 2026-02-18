select column_name, data_type
from information_schema.columns
where table_schema='public' and table_name='raw_orders'
order by ordinal_position;

select column_name, data_type
from information_schema.columns
where table_schema='public' and table_name='raw_order_items'
order by ordinal_position;