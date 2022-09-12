{{
    config(
        materialized='view'
    )
}}

select 
    *
from {{ ref('__query_history__') }} history
where node_id in (select unique_id from {{ ref('__active_models__')}} )
order by start_time desc
