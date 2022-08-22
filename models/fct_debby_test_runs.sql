{{
    config(
        materialized='view'
    )
}}


{# 
TODO: rather than checking rows_produced = 0 to determine if the test was 
successful, we can pull in the context to check that its rows_produced is
less than the specified threshold.
#}

select
    query_id,
    node:node_name::varchar as name,
    {# This logic requires that the dbt project stores failures #}
    error_code is null and rows_produced is null as is_success,
    node:node_id::varchar as unique_id,
    start_time,
    end_time,
    total_elapsed_time::float / 1000 as elapsed_time_in_seconds,
    error_code,
    error_message,
    execution_time,
    rows_produced,
    rows_inserted,
    rows_deleted,
    rows_updated
from {{ ref('fct_debby_query_history') }}
where resource_type = 'test'
order by start_time desc
