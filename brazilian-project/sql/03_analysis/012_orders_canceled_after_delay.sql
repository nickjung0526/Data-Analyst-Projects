
-- This series uses join to use the customer_id and assign to the unique_customer_id,
-- then use join of raw_orders to see how many reorders they do.
WITH order_base AS (
    SELECT
        raw_orders.order_id,
        raw_customers.customer_unique_id,
        raw_orders.order_purchase_timestamp::TIMESTAMP as purchase_date,
        CASE
            WHEN order_delivered_customer_date::TIMESTAMP > order_estimated_delivery_date::TIMESTAMP
                THEN 'Late'
                ELSE 'On Time'
            END AS delivery_status
    FROM public.raw_orders
    INNER JOIN public.raw_customers
        ON public.raw_orders.customer_id = public.raw_customers.customer_id 
    ),

order_sequence AS (
    SELECT 
        order_id,
        customer_unique_id,
        delivery_status,
        purchase_date,
        LEAD(purchase_date) OVER (
            PARTITION BY customer_unique_id
            ORDER BY purchase_date) AS next_purchase_date
        FROM order_base
        )


SELECT 
    delivery_status,
    COUNT(*) AS total_base_orders,
    COUNT(next_purchase_date) AS total_repeat_orders,
    ROUND((COUNT(next_purchase_date)::NUMERIC / COUNT(*)) * 100, 2) AS
repeat_purchase_rate_percent,


    ROUND(AVG(EXTRACT(DAY FROM( next_purchase_date - purchase_date))::NUMERIC),2 ) AS
    avg_days_to_repurchase

    FROM order_sequence
    GROUP BY 1;
