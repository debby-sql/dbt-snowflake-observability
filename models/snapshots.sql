{{
    config(
        materialized='view'
    )
}}

select *
from {{ ref('__active_snapshots__') }}
