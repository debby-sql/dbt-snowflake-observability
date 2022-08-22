{{
    config(
        materialized='view'
    )
}}

{# 

TODO: for models with multiple statements, should we combine the statements
or is it enough to view only the last statement as we do currently?

TODO: how can we pull in the test status to this model? I think we may have to
parent_map and child_map to the node context

#}

select
    query_id,
    name,
    is_success as is_built,
    unique_id,
    start_time,
    end_time,
    elapsed_time_in_seconds,
    error_code,
    error_message,
    execution_time,
    rows_produced,
    rows_inserted,
    rows_deleted,
    rows_updated
from {{ ref('fct_debby_model_runs') }}
where unique_id in (select unique_id from {{ ref('dim_debby_active_models') }})
qualify row_number() over (partition by name order by start_time desc) = 1
