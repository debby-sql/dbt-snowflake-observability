{{
    config(
        materialized='view'
    )
}}

select 
    *,
    coalesce(rows_produced, 0) as num_failing_rows
from {{ ref('__query_history__') }} history
where node_id in (select test_id from {{ ref('__active_tests__')}} )
order by start_time desc
