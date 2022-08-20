{{
    config(
        materialized='view'
    )
}}

select 
    regexp_substr(query_text, '(\&\&DEBBY_COMMENT_START)(.*)(\&\&DEBBY_COMMENT_END)',1,1,'e',2) as debby_query_comment_raw,
    try_parse_json(debby_query_comment_raw) as debby_query_comment,
    debby_query_comment is not null as debby_is_valid,
    debby_query_comment:node as node,
    node:node_id::varchar is not null as is_relation,
    node:resource_type::varchar as resource_type,
    debby_query_comment:dbt:invocation_id::varchar as invocation_id,
    debby_query_comment:dbt:profile_name::varchar as profile_name,
    debby_query_comment:dbt:target_name::varchar as target_name,
    debby_query_comment:dbt:version::varchar as dbt_version,
    *
from {{ source('snowflake', 'query_history') }}
where debby_is_valid
order by start_time desc
