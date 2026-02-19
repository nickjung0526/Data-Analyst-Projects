
WITH delivery_categorization AS (
SELECT
    order_id,
    customer_id,
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
    public.raw_customers.customer_state,
    COUNT(*) as total_late_orders, --aggregate
    ROUND(AVG(public.raw_order_reviews.review_score::NUMERIC), 2) AS average_review_score
FROM delivery_categorization

-- Join reviews to get the scores
LEFT JOIN public.raw_order_reviews 
    ON delivery_categorization.order_id = public.raw_order_reviews.order_id

-- Join customers to get states
LEFT JOIN public.raw_customers
    ON delivery_categorization.customer_id = public.raw_customers.customer_id

WHERE delivery_categorization.delivery_status = 'Late'
GROUP BY 1; 



