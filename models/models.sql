{{
    config(
        materialized='view'
    )
}}

select *
from {{ ref('__active_models__') }} model
join {{ ref('__active_model_latest_query_summary__') }} summary
on (
    model.unique_id = summary.node_id
)
