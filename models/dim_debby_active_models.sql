{{
    config(
        materialized='view'
    )
}}

select f.value::varchar as unique_id
from {{ ref('dim_debby_active_resources') }} resources,
lateral flatten(input => resources.models) f
