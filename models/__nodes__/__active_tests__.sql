{{
    config(
        materialized='table'
    )
}}

with test_ids as (
    select 
        f.value:unique_id::varchar as unique_id,
        f.value:name::varchar as name,
        f.value:depends_on:nodes as nodes
    from {{ ref('__active_nodes__') }} nodes,
    lateral flatten(input => nodes.tests) f
)

select
    test_ids.unique_id,
    test_ids.name,
    f.value::varchar as node_id
from test_ids,
lateral flatten(input => test_ids.nodes) f