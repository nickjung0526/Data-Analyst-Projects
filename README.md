Brazilian E-Commerce: Delivery Delays and Review Impact (Olist)

What I built

I set up a SQL-first analytics pipeline in PostgreSQL on ~100k Olist orders. The goal was to quantify delivery reliability (on-time vs late) and measure how delays affect customer review scores.

Stack

PostgreSQL • SQL (CTEs, joins, window functions, CASE) • Git/GitHub
Pipeline structure: raw → staging → data quality checks → analysis tables

Data pipeline
	•	raw: loaded CSVs into raw_* tables with COPY
	•	stg: typed and cleaned fields (timestamps, numerics, IDs), standardized column names
	•	dq: SQL checks logged to dq.dq_results (PK nulls/dupes, negative values, referential integrity)
	•	analysis: queries answering delivery performance + review impact

Findings

Late delivery is strongly associated with worse reviews.
I labeled each order as On Time or Late based on order_delivered_customer_date > order_estimated_delivery_date and compared average review scores.

Delays are concentrated geographically.
I grouped late-rate by customer_state to identify where delays occur most often (high-volume states are also the biggest drivers of total late orders).
