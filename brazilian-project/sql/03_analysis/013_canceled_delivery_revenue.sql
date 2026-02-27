WITH order_freight AS (

SELECT 
    public.raw_orders.order_status,
    public.raw_orders.order_id,
    public.raw_order_items.freight_value,
    public.raw_order_items.price
FROM public.raw_orders
LEFT JOIN public.raw_order_items
    ON public.raw_order_items.order_id = public.raw_orders.order_id
)

SELECT
    order_status,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(freight_value::numeric) as freight_cost,
    SUM(freight_value::NUMERIC + price::NUMERIC) as total_cost
    FROM order_freight
    WHERE order_status = 'delivered' OR order_status = 'canceled'
    GROUP BY order_status;
