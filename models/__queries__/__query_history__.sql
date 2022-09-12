{{
    config(
        materialized='view'
    )
}}

select 
    regexp_substr(query_text, '(\&\&DEBBY_COMMENT_START)(.*)(\&\&DEBBY_COMMENT_END)',1,1,'e',2) as raw_query_comment,
    try_parse_json(raw_query_comment) as parsed_query_comment,
    parsed_query_comment is not null as has_valid_comment,
    parsed_query_comment:node:node_id::varchar is not null as is_node,
    parsed_query_comment:node:node_id::varchar as node_id,
    parsed_query_comment:node:resource_type::varchar as resource_type,
    parsed_query_comment:dbt:invocation_id::varchar as invocation_id,
    parsed_query_comment:dbt:profile_name::varchar as profile_name,
    parsed_query_comment:dbt:target_name::varchar as target_name,
    parsed_query_comment:dbt:version::varchar as dbt_version,
    *
from {{ source('snowflake', 'query_history') }}
where has_valid_comment
order by start_time desc
