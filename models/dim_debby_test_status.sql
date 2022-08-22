{{
    config(
        materialized='view'
    )
}}


select
    
    name,
    is_success as is_passing,
    unique_id,
    start_time,
    end_time,
    elapsed_time_in_seconds,
    rows_produced as failing_records,
    error_code,
    query_id
from {{ ref('fct_debby_test_runs') }}
where unique_id in (select unique_id from {{ ref('dim_debby_active_tests') }})
qualify row_number() over (partition by name order by start_time desc) = 1
