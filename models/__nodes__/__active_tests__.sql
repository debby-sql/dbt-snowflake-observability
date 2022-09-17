{{
    config(
        materialized='table'
    )
}}

with test_ids as (
    select 
        f.value:unique_id::varchar as test_id,
        f.value:name::varchar as name,
        f.value:depends_on:nodes as depends_on
    from {{ ref('__active_nodes__') }} nodes,
    lateral flatten(input => nodes.tests) f
)

select
    test_ids.test_id,
    test_ids.name,
    f.value::varchar as depends_on
from test_ids,
lateral flatten(input => test_ids.depends_on) f