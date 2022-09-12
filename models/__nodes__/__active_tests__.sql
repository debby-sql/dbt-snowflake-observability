{{
    config(
        materialized='table'
    )
}}

select 
    f.value:unique_id::varchar as unique_id,
    f.value:name::varchar as name,
    f.value:depends_on:nodes as nodes
from {{ ref('__active_nodes__') }} nodes,
lateral flatten(input => nodes.tests) f
