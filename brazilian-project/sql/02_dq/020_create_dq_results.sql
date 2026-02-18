BEGIN;

CREATE SCHEMA IF NOT EXISTS dq; 
DROP TABLE IF EXISTS dq.dq_results;

CREATE TABLE dq.dq_results (
    run_ts timestamptz NOT NULL DEFAULT now(),
    check_name text NOT NULL,
    category text NOT NULL,
    status text NOT NULL,
    failed_count integer NOT NULL,
    sample_ids text,
    notes text
);
COMMIT;

