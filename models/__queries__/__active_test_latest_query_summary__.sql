{{
    config(
        materialized='view'
    )
}}

select 
    *,
    coalesce(rows_produced, 0) as num_failing_rows
from {{ ref('__active_test_latest_query_history__') }} history
where query_type = 'CREATE_TABLE_AS_SELECT'