{{
    config(
        materialized='table'
    )
}}

select 
    f.value:name::varchar as name,
    f.value:unique_id::varchar as unique_id,
    f.value:database::varchar as database,
    f.value:schema::varchar as schema
from {{ ref('__active_nodes__') }} nodes,
lateral flatten(input => nodes.models) f
