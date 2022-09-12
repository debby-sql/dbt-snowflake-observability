{{
    config(
        materialized='view'
    )
}}

select
    test.name,
    test.unique_id,
    test.node_id,
    summary.num_failing_rows
from {{ ref('__active_tests__') }} test
join {{ ref('__active_test_latest_query_summary__') }} summary
on (
    test.unique_id = summary.node_id
)
