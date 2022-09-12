{{
    config(
        materialized='view'
    )
}}

with latest_invocations as (
    select
        node_id, 
        invocation_id
    from {{ ref('__active_test_query_history__') }}
    qualify row_number() over (partition by node_id order by end_time desc) = 1
)

select 
    *,
    end_time as last_ran_at
from {{ ref('__active_test_query_history__') }} history
join latest_invocations using (node_id, invocation_id)
order by end_time desc
