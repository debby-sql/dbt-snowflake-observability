{{
    config(
        materialized='view'
    )
}}

select
    test.name,
    test.test_id,
    summary.num_failing_rows
from {{ ref('__active_tests__') }} test
join {{ ref('__active_test_latest_query_summary__') }} summary
on (
    test.test_id = summary.test_id
)
