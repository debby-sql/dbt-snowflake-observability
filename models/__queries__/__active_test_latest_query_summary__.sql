{{
    config(
        materialized='view'
    )
}}

select 
    *
from {{ ref('__active_test_latest_query_history__') }} history
where query_type = 'CREATE_TABLE_AS_SELECT'