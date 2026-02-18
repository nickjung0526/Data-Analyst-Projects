WITH failing as (
    SELECT order_id
    FROM stg.stg_order_items
    WHERE price < 0 or price IS NULL
),
summary as (
    SELECT count(*) as failed_count from failing
)
INSERT INTO dq.dq_results (check_name, category, status, failed_count, sample_ids, notes)
SELECT 
'order_items_price_nonnegative',
'validity',
CASE WHEN failed_count = 0 then 'PASS' else 'FAIL' end,
failed_count,
NULL,
'price should be >= 0 and not null'
from summary;

