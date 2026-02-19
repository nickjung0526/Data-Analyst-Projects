-- This is an example of CTE, temp mini-table to run at exact moment of query
WITH delivery_categorization AS (
SELECT
    order_id,
    order_status,
    CASE 
        WHEN order_delivered_customer_date::TIMESTAMP > order_estimated_delivery_date::TIMESTAMP
        THEN 'Late'
        ELSE 'On Time'
    END AS delivery_status
FROM public.raw_orders
WHERE order_status = 'delivered'
)
--how many late vs on time 
SELECT
    delivery_categorization.delivery_status,
    COUNT(*) as total_orders, --aggregate
    
    ROUND(AVG(public.raw_order_reviews.review_score::NUMERIC), 2) AS average_review_score

FROM delivery_categorization

LEFT JOIN public.raw_order_reviews
    ON delivery_categorization.order_id = public.raw_order_reviews.order_id

GROUP BY 1; 



