{{
    config(
        materialized='view'
    )
}}

select
    model.unique_id,
    model.name,
    model.database,
    model.schema,
    model.materialization,
    summary.end_time as last_built_at,
    summary.statements as statements,
    timediff('milliseconds', summary.start_time, summary.end_time) as build_time_ms,
    summary.execution_time_ms as compute_time_ms,
    summary.queued_time_ms as queued_time,
    summary.compilation_time_ms as compilation_time_ms,
    summary.target_name as target_name
from {{ ref('__active_models__') }} model
join {{ ref('__active_model_latest_query_summary__') }} summary
on (
    model.unique_id = summary.node_id
)
