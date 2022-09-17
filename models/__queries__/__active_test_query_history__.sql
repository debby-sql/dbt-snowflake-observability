{{
    config(
        materialized='view'
    )
}}

select 
    node_id as test_id,
    coalesce(rows_produced, 0) as num_failing_rows
from {{ ref('__query_history__') }} history
where test_id in (select test_id from {{ ref('__active_tests__')}} )
order by start_time desc
