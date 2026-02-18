WITH failing AS (
  SELECT order_id
  FROM public.raw_orders
  WHERE order_id IS NULL
),
summary AS (
  SELECT COUNT(*) AS failed_count
  FROM failing
)
INSERT INTO dq.dq_results (check_name, category, status, failed_count, sample_ids, notes)
SELECT
  'orders_pk_not_null',
  'validity',
  CASE WHEN failed_count = 0 THEN 'PASS' ELSE 'FAIL' END,
  failed_count,
  NULL,
  'order_id should never be NULL'
FROM summary;



