{{
    config(
        materialized='view'
    )
}}

select 
    f.value:unique_id::varchar as unique_id,
    f.value:name::varchar as name,
    f.value:depends_on:nodes as nodes
from {{ ref('active_nodes') }} nodes,
lateral flatten(input => nodes.tests) f
