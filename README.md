# Brazilian E-Commerce: Delivery Delays and Review Impact (Olist)

## What I built
I set up a SQL-first analytics pipeline in PostgreSQL analyzing ~100k Olist orders. The goal was to quantify delivery reliability (on-time vs. late) and measure exactly how delays affect customer review scores.

**Tech Stack:** PostgreSQL • SQL (CTEs, joins, window functions, `CASE`) • Git/GitHub  
**Pipeline Structure:** Raw → Staging → Data Quality → Analysis

## The Data Pipeline
* **Raw:** Loaded CSVs directly into `raw_*` tables using `COPY`.
* **Staging (`stg`):** Cleaned and typed fields (timestamps, numerics, IDs) and standardized column names.
* **Data Quality (`dq`):** Built automated SQL checks for PK nulls/dupes, negative values, and referential integrity, logging everything to a `dq.dq_results` table.
* **Analysis:** Wrote the final reporting queries to answer questions about delivery performance and review impact.

## Key Findings
* **Late delivery is strongly associated with worse reviews:** I labeled each order as "On Time" or "Late" (evaluating `order_delivered_customer_date > order_estimated_delivery_date`) and found a significant drop in average review scores for delayed orders.
* **Delays are concentrated geographically:** I grouped the two highest states with most frequent delays for further analysis.
* Late deliveries actively destroy customer retention: Conducted a cohort analysis using Window Functions (LEAD) to track repeat purchase behavior. Discovered that customers with on-time deliveries have a 3.41% repeat purchase rate, compared to just 2.80% for those who experience delays. This means poor logistic causes a ~ 21% relative drop in customer retention
