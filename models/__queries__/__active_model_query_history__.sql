{{
    config(
        materialized='view'
    )
}}

select 
    *,
    first_value(error_code) ignore nulls over (partition by target_name, node_id, invocation_id order by start_time desc) as build_error_code,
    first_value(error_message) ignore nulls over (partition by target_name, node_id, invocation_id order by start_time desc) as build_error_message,
    build_error_code is not null as has_build_error
from {{ ref('__query_history__') }} history
where node_id in (select unique_id from {{ ref('__active_models__')}} )
order by start_time desc
