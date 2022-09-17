{{
    config(
        materialized='view'
    )
}}

with latest_invocations as (
    select
        node_id, 
        invocation_id,
        target_name
    from {{ ref('__active_model_query_history_summary__') }}
    qualify row_number() over (partition by target_name, node_id order by end_time desc) = 1
)

select 
    *
from {{ ref('__active_model_query_history_summary__') }} history
join latest_invocations using (node_id, invocation_id, target_name)
order by end_time desc
