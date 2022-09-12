{{
    config(
        materialized='table'
    )
}}

select 
    f.value:unique_id::varchar as unique_id,
    f.value:name::varchar as name,
    f.value:database::varchar as database,
    f.value:schema::varchar as schema,
    f.value:identifier::varchar as identifier
from {{ ref('__active_nodes__') }} nodes,
lateral flatten(input => nodes.sources) f
